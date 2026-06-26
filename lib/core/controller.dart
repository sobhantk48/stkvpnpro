import 'dart:async';
import 'package:flutter/services.dart';

class CoreController {
  static const MethodChannel _channel = MethodChannel('core_channel');
  static const EventChannel _logChannel = EventChannel('core_logs');
  static const EventChannel _trafficChannel = EventChannel('core_traffic');

  static StreamSubscription? _logSub;
  static StreamSubscription? _trafficSub;

  static Stream<String> getLogs() {
    return _logChannel.receiveBroadcastStream().map((event) => event.toString());
  }

  static Stream<String> getTraffic() {
    return _trafficChannel.receiveBroadcastStream().map((event) => event.toString());
  }

  static void dispose() {
    _logSub?.cancel();
    _trafficSub?.cancel();
  }

  static Future<String> startCore(String type, String config) async {
    try {
      final result = await _channel.invokeMethod('startCore', {
        'type': type,
        'config': config,
      });
      return result.toString();
    } catch (e) {
      return 'Error: $e';
    }
  }

  static Future<String> stopCore() async {
    try {
      final result = await _channel.invokeMethod('stopCore');
      return result.toString();
    } catch (e) {
      return 'Error: $e';
    }
  }
}
