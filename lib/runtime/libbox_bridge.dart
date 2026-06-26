import 'package:flutter/services.dart';

class LibboxBridge {

  static const MethodChannel
      _channel =
      MethodChannel(
        'stk_vpn/native',
      );

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
        .toString();
  }
}
