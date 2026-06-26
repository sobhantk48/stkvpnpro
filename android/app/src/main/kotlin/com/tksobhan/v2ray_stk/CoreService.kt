package com.tksobhan.v2ray_stk

import android.app.*
import android.content.Intent
import android.net.VpnService
import android.os.*
import android.util.Log
import androidx.core.app.NotificationCompat
import java.io.File

class CoreService : VpnService() {

    companion object {
        private const val CHANNEL_ID = "vpn_pro"
        private const val NOTIFICATION_ID = 1001
    }

    private var process: Process? = null
    private var vpn: ParcelFileDescriptor? = null
    private val handler = Handler(Looper.getMainLooper())

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        val type = intent?.getStringExtra("type") ?: "singbox"
        val config = intent?.getStringExtra("config") ?: ""

        startForegroundService()

        if (config.isBlank()) {
            Log.e("CORE", "empty config")
            return START_NOT_STICKY
        }

        val file = File(filesDir, "config.json")
        file.writeText(config)

        vpn = establishVpn()

        when (type) {
            "singbox" -> startSingBox(file.absolutePath)
            "xray" -> startXray(file.absolutePath)
        }

        return START_STICKY
    }

    private fun startForegroundService() {
        val manager = getSystemService(NotificationManager::class.java)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "VPN Service",
                NotificationManager.IMPORTANCE_LOW
            )
            manager.createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("VPN Running")
            .setContentText("Connected")
            .setSmallIcon(android.R.drawable.stat_sys_download_done)
            .build()

        startForeground(NOTIFICATION_ID, notification)
    }

    private fun establishVpn(): ParcelFileDescriptor? {
        return Builder()
            .setSession("Clash-Grade-VPN")
            .addAddress("172.19.0.1", 30)
            .addRoute("0.0.0.0", 0)
            .addDnsServer("1.1.1.1")
            .setMtu(1500)
            .establish()
    }

    private fun startSingBox(path: String) {
        stopCore()

        val bin = File(filesDir, "sing-box")
        if (!bin.exists()) return

        process = Runtime.getRuntime().exec(
            arrayOf(bin.absolutePath, "run", "-c", path)
        )

        readLogs()
    }

    private fun startXray(path: String) {
        stopCore()

        val bin = File(filesDir, "xray")
        if (!bin.exists()) return

        process = Runtime.getRuntime().exec(
            arrayOf(bin.absolutePath, "-config", path)
        )

        readLogs()
    }

    private fun readLogs() {
        val p = process ?: return

        Thread {
            try {
                p.inputStream.bufferedReader().forEachLine {
                    Log.d("CORE", it)
                    MainActivity.logSink?.success(it)
                }
            } catch (_: Exception) {}
        }.start()

        Thread {
            try {
                p.errorStream.bufferedReader().forEachLine {
                    Log.e("CORE", it)
                }
            } catch (_: Exception) {}
        }.start()
    }

    private fun stopCore() {
        try {
            process?.destroyForcibly()
        } catch (_: Exception) {}
        process = null
    }

    override fun onDestroy() {
        stopCore()
        vpn?.close()
        vpn = null
        super.onDestroy()
    }
}
