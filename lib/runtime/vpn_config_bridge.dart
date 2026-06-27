import 'package:flutter/services.dart';

class VpnConfigBridge {

  static const MethodChannel _ch =
      MethodChannel('stk_vpn/native');

  static Future<String> startWithConfig(
      String config,
  ) async {

    final result =
        await _ch.invokeMethod(
            'startVpn',
            {
              "config": config,
              "type": "singbox",
            }
        );

    return result.toString();
  }

  static Future<String> stop() async {

    final result =
        await _ch.invokeMethod('stopVpn');

    return result.toString();
  }
}
