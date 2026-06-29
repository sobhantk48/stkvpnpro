import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'notification_service.dart';

enum VpnStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
  disconnecting,
  error,
}

class VpnService {
  static final VpnService _instance = VpnService._internal();
  factory VpnService() => _instance;
  VpnService._internal();

  static const MethodChannel _channel = MethodChannel('stk_vpn/vpn');
  
  final NotificationService _notif = NotificationService();
  VpnStatus _status = VpnStatus.disconnected;

  VpnStatus get status => _status;

  Future<void> initialize() async {
    try {
      await _notif.init();
      debugPrint('✅ VpnService مقداردهی شد');
    } catch (e) {
      debugPrint('❌ خطا: $e');
      rethrow;
    }
  }

  /// شروع VPN با config JSON
  Future<bool> startVpn(String configJson) async {
    try {
      _status = VpnStatus.connecting;
      
      final result = await _channel.invokeMethod<bool>(
        'startVpn',
        {'config': configJson},
      );
      
      _status = (result ?? false) ? VpnStatus.connected : VpnStatus.error;
      
      if (_status == VpnStatus.connected) {
        await _notif.showPersistentNotification(
          '✅ VPN وصل شد',
          'اتصال برقرار است',
        );
        debugPrint('✅ VPN متصل');
        return true;
      } else {
        throw Exception('شروع VPN ناموفق');
      }
    } on PlatformException catch (e) {
      _status = VpnStatus.error;
      await _notif.showNotification('❌ خطا', 'خطا: ${e.message}');
      debugPrint('❌ Platform Error: ${e.message}');
      return false;
    } catch (e) {
      _status = VpnStatus.error;
      await _notif.showNotification('❌ خطا', 'خطا: $e');
      debugPrint('❌ خطا: $e');
      return false;
    }
  }

  /// قطع VPN
  Future<bool> stopVpn() async {
    try {
      _status = VpnStatus.disconnecting;
      
      final result = await _channel.invokeMethod<bool>('stopVpn');
      
      _status = VpnStatus.disconnected;
      
      await _notif.cancelAll();
      await _notif.showNotification(
        '✅ VPN قطع شد',
        'اتصال خاتمه یافت',
      );
      
      debugPrint('✅ VPN قطع شد');
      return result ?? true;
    } on PlatformException catch (e) {
      _status = VpnStatus.error;
      debugPrint('❌ Platform Error: ${e.message}');
      return false;
    } catch (e) {
      _status = VpnStatus.error;
      debugPrint('❌ خطا: $e');
      return false;
    }
  }

  /// Toggle VPN
  Future<bool> toggleVpn(String configJson) async {
    if (_status == VpnStatus.connected) {
      return await stopVpn();
    } else {
      return await startVpn(configJson);
    }
  }

  /// دریافت ترافیک
  Future<Map<String, dynamic>> getTraffic() async {
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'getTraffic',
      );
      
      if (result == null) {
        return {
          'upload': 0.0,
          'download': 0.0,
          'ping': 0,
        };
      }
      
      return {
        'upload': (result['upload'] as num?)?.toDouble() ?? 0.0,
        'download': (result['download'] as num?)?.toDouble() ?? 0.0,
        'ping': (result['ping'] as num?)?.toInt() ?? 0,
      };
    } catch (e) {
      debugPrint('❌ خطا در getTraffic: $e');
      return {
        'upload': 0.0,
        'download': 0.0,
        'ping': 0,
      };
    }
  }

  /// دریافت وضعیت
  Future<VpnStatus> getStatus() async {
    try {
      final result = await _channel.invokeMethod<bool>('isConnected');
      return (result ?? false) ? VpnStatus.connected : VpnStatus.disconnected;
    } catch (e) {
      return _status;
    }
  }
}