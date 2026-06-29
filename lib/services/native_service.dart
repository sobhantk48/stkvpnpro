import 'package:flutter/services.dart';
import 'dart:developer' as developer;

class NativeService {
  static const MethodChannel _channel = MethodChannel('stk_vpn/native');
  static const EventChannel _trafficChannel = EventChannel('stk_vpn/traffic');

  static Stream<Map<String, dynamic>> get trafficStream {
    return _trafficChannel.receiveBroadcastStream().map((event) {
      if (event is Map) {
        return Map<String, dynamic>.from(event);
      }
      return {};
    });
  }

  /// Ping test
  static Future<int?> ping({required String server}) async {
    try {
      final result = await _channel.invokeMethod<int>(
        'ping',
        {'server': server},
      );
      return result;
    } on PlatformException catch (e) {
      developer.log('❌ Ping failed: ${e.message}');
      return null;
    }
  }

  /// شروع VPN
  static Future<bool> startVpn({
    required String configJson,
    required String protocol,
  }) async {
    try {
      final result = await _channel.invokeMethod<bool>(
        'startVpn',
        {
          'config': configJson,
          'protocol': protocol,
        },
      );
      return result ?? false;
    } on PlatformException catch (e) {
      developer.log('❌ Start VPN failed: ${e.message}');
      rethrow;
    }
  }

  /// توقف VPN
  static Future<bool> stopVpn() async {
    try {
      final result = await _channel.invokeMethod<bool>('stopVpn');
      return result ?? false;
    } on PlatformException catch (e) {
      developer.log('❌ Stop VPN failed: ${e.message}');
      rethrow;
    }
  }

  /// دریافت وضعیت
  static Future<Map<String, dynamic>?> getStatus() async {
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('getStatus');
      if (result == null) return null;
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      developer.log('❌ Get status failed: ${e.message}');
      return null;
    }
  }

  /// دریافت ترافیک
  static Future<Map<String, dynamic>?> getTraffic() async {
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('getTraffic');
      if (result == null) return null;
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      developer.log('❌ Get traffic failed: ${e.message}');
      return null;
    }
  }
}