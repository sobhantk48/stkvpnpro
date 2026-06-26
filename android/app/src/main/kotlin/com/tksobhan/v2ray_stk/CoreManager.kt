package com.tksobhan.v2ray_stk

import android.content.Context
import android.util.Log
import java.io.File

class CoreManager(private val context: Context) {

    private var currentProcess: Process? = null
    private var currentCore: String? = null

    fun startSingBox(config: String) {
        stopAll()
        Log.d("CORE_MANAGER", "🚀 شروع sing-box...")

        try {
            val binary = File(context.filesDir, "sing-box")
            if (!binary.exists()) {
                Log.e("CORE_MANAGER", "❌ فایل sing-box در مسیر ${binary.absolutePath} وجود ندارد")
                return
            }
            Runtime.getRuntime().exec(arrayOf("chmod", "755", binary.absolutePath))

            currentProcess = Runtime.getRuntime().exec(
                arrayOf(binary.absolutePath, "run", "-c", config)
            )
            currentCore = "singbox"
            Log.d("CORE_MANAGER", "✅ sing-box با موفقیت شروع شد")
        } catch (e: Exception) {
            Log.e("CORE_MANAGER", "❌ خطا در شروع sing-box: ${e.message}")
        }
    }

    fun startXray(config: String) {
        stopAll()
        Log.d("CORE_MANAGER", "🚀 شروع xray...")

        try {
            val binary = File(context.filesDir, "xray")
            if (!binary.exists()) {
                Log.e("CORE_MANAGER", "❌ فایل xray در مسیر ${binary.absolutePath} وجود ندارد")
                return
            }
            Runtime.getRuntime().exec(arrayOf("chmod", "755", binary.absolutePath))

            currentProcess = Runtime.getRuntime().exec(
                arrayOf(binary.absolutePath, "-config", config)
            )
            currentCore = "xray"
            Log.d("CORE_MANAGER", "✅ xray با موفقیت شروع شد")
        } catch (e: Exception) {
            Log.e("CORE_MANAGER", "❌ خطا در شروع xray: ${e.message}")
        }
    }

    fun stopAll() {
        try {
            currentProcess?.destroy()
            currentProcess = null
            currentCore = null
            Log.d("CORE_MANAGER", "✅ همه هسته‌ها متوقف شدند")
        } catch (e: Exception) {
            Log.e("CORE_MANAGER", "❌ خطا در توقف: ${e.message}")
        }
    }

    fun getCurrent(): String {
        return currentCore ?: "none"
    }
}
