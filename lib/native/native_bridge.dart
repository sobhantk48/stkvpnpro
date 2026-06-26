import 'package:flutter/services.dart';

class NativeBridge {

  static const MethodChannel
      _channel =
      MethodChannel(
        'stk_vpn/native',
      );

  static Future<String>
      ping() async {

    final result =
        await _channel.invokeMethod(
      'ping',
    );

    return result;
  }
}
