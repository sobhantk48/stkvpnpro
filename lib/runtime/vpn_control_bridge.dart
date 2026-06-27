import 'package:flutter/services.dart';

class VpnControlBridge {

  static const MethodChannel _ch =
      MethodChannel('stk_vpn/native');

  static Future<String> start() async {

    final r = await _ch.invokeMethod('vpnStart');

    return r.toString();
  }

  static Future<String> stop() async {

    final r = await _ch.invokeMethod('vpnStop');

    return r.toString();
  }
}
