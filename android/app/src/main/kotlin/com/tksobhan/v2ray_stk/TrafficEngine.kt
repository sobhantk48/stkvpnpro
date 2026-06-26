package com.tksobhan.v2ray_stk

import android.net.TrafficStats
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel

class TrafficEngine(
    private val sink: EventChannel.EventSink?
) {
    private val handler = Handler(Looper.getMainLooper())
    private var lastRx = TrafficStats.getTotalRxBytes()
    private var lastTx = TrafficStats.getTotalTxBytes()

    fun start() {
        handler.post(object : Runnable {
            override fun run() {

                val rx = TrafficStats.getTotalRxBytes()
                val tx = TrafficStats.getTotalTxBytes()

                val down = rx - lastRx
                val up = tx - lastTx

                lastRx = rx
                lastTx = tx

                sink?.success("${down / 1024} KB/s / ${up / 1024} KB/s")

                handler.postDelayed(this, 1000)
            }
        })
    }
}
