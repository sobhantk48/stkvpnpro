import 'package:flutter/services.dart';

class NativeRuntime {

  static const MethodChannel
      _channel =
      MethodChannel(
        "stk_vpn/native",
      );

  static Future<String>
      initialize() async {

    final result =
        await _channel
            .invokeMethod(
                "runtimeInit");

    return result
        .toString();
  }
}
