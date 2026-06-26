import 'package:flutter/services.dart';

class NativeService {

  static const MethodChannel
      _channel =
      MethodChannel(
        'stk_vpn/native',
      );

  static Future<String>
      ping() async {

    try {

      final result =
          await _channel
              .invokeMethod(
                  'ping');

      return result
          .toString();

    } catch (e) {

      return e.toString();
    }
  }

  static Future<String>
      startVpn() async {

    try {

      final result =
          await _channel
              .invokeMethod(
                  'startVpn');

      return result
          .toString();

    } catch (e) {

      return e.toString();
    }
  }

  static Future<String>
      stopVpn() async {

    try {

      final result =
          await _channel
              .invokeMethod(
                  'stopVpn');

      return result
          .toString();

    } catch (e) {

      return e.toString();
    }
  }
}
