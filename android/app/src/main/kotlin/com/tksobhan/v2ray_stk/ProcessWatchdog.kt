package com.tksobhan.v2ray_stk

import android.os.Handler
import android.os.Looper
import android.util.Log
import java.lang.Process

class ProcessWatchdog(
    private val processProvider: () -> Process?
) {
    private val handler = Handler(Looper.getMainLooper())
    private var running = false

    fun start() {
        running = true
        handler.post(checkRunnable)
    }

    fun stop() {
        running = false
        handler.removeCallbacksAndMessages(null)
    }

    private val checkRunnable = object : Runnable {
        override fun run() {
            if (!running) return

            val proc = processProvider()

            if (proc == null) {
                Log.e("WATCHDOG", "⚠️ Process is null → should restart")
            } else {
                try {
                    val exitValue = proc.exitValue()
                    Log.e("WATCHDOG", "❌ Process died with code $exitValue")
                } catch (_: IllegalThreadStateException) {
                    // still running
                }
            }

            handler.postDelayed(this, 4000)
        }
    }
}
