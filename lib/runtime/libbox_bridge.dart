import 'package:flutter/services.dart';

class LibboxBridge {

  static const MethodChannel
      _channel =
      MethodChannel(
          'stk_vpn/native');

  static Future<bool>
      initialize() async {

    final result =
        await _channel
            .invokeMethod(
                'libboxInit');

    return result == true;
  }

  static Future<String>
      version() async {

    final result =
        await _channel
            .invokeMethod(
                'libboxVersion');

    return result
            ?.toString() ??
        'unknown';
  }

  static Future<String>
      ping() async {

    final result =
        await _channel
            .invokeMethod(
                'ping');

    return result
            ?.toString() ??
        '';
  }

  static Future<String>
      startVpn() async {

    final result =
        await _channel
            .invokeMethod(
                'startVpn');

    return result
            ?.toString() ??
        '';
  }

  static Future<String>
      stopVpn() async {

    final result =
        await _channel
            .invokeMethod(
                'stopVpn');

    return result
            ?.toString() ??
        '';
  }
}
