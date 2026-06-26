package com.tksobhan.v2ray_stk

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL =
        "stk_vpn/native"

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {

        super.configureFlutterEngine(
            flutterEngine
        )

        MethodChannel(
            flutterEngine
                .dartExecutor
                .binaryMessenger,
            CHANNEL
        ).setMethodCallHandler {

            call,
            result ->

            when (call.method) {

                "ping" ->
                    result.success(
                        "android_ok"
                    )

                "startVpn" ->
                    result.success(
                        "vpn_start_ready"
                    )

                "stopVpn" ->
                    result.success(
                        "vpn_stop_ready"
                    )

                "runtimeInit" ->
                    result.success(
                        "runtime_ready"
                    )

                else ->
                    result.notImplemented()
            }
        }
    }
}
