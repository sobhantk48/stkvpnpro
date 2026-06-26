package com.tksobhan.v2ray_stk

import android.app.Service
import android.content.Intent
import android.os.IBinder

class ForegroundKeeper : Service() {

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // keep service alive
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
