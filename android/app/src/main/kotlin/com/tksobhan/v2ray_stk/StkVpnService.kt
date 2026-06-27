package com.tksobhan.v2ray_stk

import android.content.Intent
import android.net.VpnService

class StkVpnService : VpnService() {

    fun start(config: String, type: String) {

        val intent = Intent(this, CoreService::class.java)

        intent.putExtra("config", config)

        intent.putExtra("type", type)

        startService(intent)
    }

    fun stop() {

        val intent = Intent(this, CoreService::class.java)

        stopService(intent)
    }
}
