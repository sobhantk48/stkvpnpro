package com.tksobhan.v2ray_stk

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        var logSink: EventChannel.EventSink? = null
    }

    private val CHANNEL = "stk_vpn/native"
    private val LOG_CHANNEL = "stk_vpn/logs"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Log channel for CoreService → Flutter
        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            LOG_CHANNEL
        ).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                logSink = events
            }

            override fun onCancel(arguments: Any?) {
                logSink = null
            }
        })

        // Method channel for Flutter → Android
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {

                "ping" -> result.success("android_ok")

                "startVpn" -> {
                    val config = call.argument<String>("config") ?: ""
                    val type = call.argument<String>("type") ?: "singbox"

                    val intent = Intent(this, CoreService::class.java)
                    intent.putExtra("type", type)
                    intent.putExtra("config", config)

                    startService(intent)
                    result.success("started")
                }

                "stopVpn" -> {
                    val intent = Intent(this, CoreService::class.java)
                    stopService(intent)
                    result.success("stopped")
                }

                "runtimeInit" -> result.success("runtime_ready")

                "libboxInit" -> {
                    val ok = LibboxRuntime.initialize()
                    result.success(ok)
                }

                "libboxVersion" -> result.success(LibboxRuntime.version())

                else -> result.notImplemented()
            }
        }
    }
}
