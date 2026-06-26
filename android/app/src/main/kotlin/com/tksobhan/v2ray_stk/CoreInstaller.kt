package com.tksobhan.v2ray_stk

import android.content.Context
import android.util.Log
import java.io.*
import java.net.HttpURLConnection
import java.net.URL
import java.util.zip.*

class CoreInstaller(private val context: Context) {

    fun fetchSubscription(url: String): String {
        return try {
            val conn = URL(url).openConnection() as HttpURLConnection
            conn.connectTimeout = 15000
            conn.readTimeout = 20000
            conn.inputStream.bufferedReader().readText()
        } catch (e: Exception) {
            Log.e("SUB", "fetch error: ${e.message}")
            ""
        }
    }

    fun parseSubscription(data: String): List<String> {
        return data.lines().filter {
            it.startsWith("vless://") ||
            it.startsWith("vmess://") ||
            it.startsWith("trojan://") ||
            it.startsWith("ss://")
        }
    }

    fun installIfNeeded(name: String): Boolean {

        val bin = File(context.filesDir, name)
        if (bin.exists() && bin.canExecute()) return true

        val url = when (name) {
            "sing-box" -> "https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-android-arm64.tar.gz"
            "xray" -> "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-android-arm64-v8a.zip"
            else -> return false
        }

        return try {
            val archive = File(context.filesDir, "$name.zip")
            download(url, archive)

            if (archive.length() < 2_000_000) return false

            extract(archive, context.filesDir)

            val extracted = findBinary(name)
            if (extracted != null) {
                extracted.setExecutable(true)
                extracted.renameTo(bin)
                true
            } else false

        } catch (e: Exception) {
            Log.e("INSTALL", e.message ?: "")
            false
        }
    }

    private fun download(url: String, out: File) {
        URL(url).openStream().use { input ->
            FileOutputStream(out).use { output ->
                input.copyTo(output)
            }
        }
    }

    private fun extract(file: File, dir: File) {
        if (file.name.endsWith(".zip")) {
            ZipInputStream(FileInputStream(file)).use { zip ->
                var e = zip.nextEntry
                while (e != null) {
                    val f = File(dir, e.name)
                    if (e.isDirectory) f.mkdirs()
                    else {
                        f.parentFile?.mkdirs()
                        f.outputStream().use { zip.copyTo(it) }
                    }
                    e = zip.nextEntry
                }
            }
        }
    }

    private fun findBinary(name: String): File? {
        return context.filesDir.listFiles()?.firstOrNull {
            it.name.contains(name) && it.canExecute()
        }
    }
}
