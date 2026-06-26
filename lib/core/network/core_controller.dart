import 'package:flutter/services.dart';

class CoreController {
  static const MethodChannel _channel = MethodChannel('core_channel');
  static const EventChannel _logs = EventChannel('core_logs');
  static const EventChannel _traffic = EventChannel('core_traffic');

  static Future<String> startCore(String type, String config) async {
    final res = await _channel.invokeMethod('startCore', {
      "type": type,
      "config": config,
    });
    return res.toString();
  }

  static Future<String> stopCore() async {
    final res = await _channel.invokeMethod('stopCore');
    return res.toString();
  }

  static Stream<String> getLogs() =>
      _logs.receiveBroadcastStream().map((e) => e.toString());

  static Stream<String> getTraffic() =>
      _traffic.receiveBroadcastStream().map((e) => e.toString());
}
