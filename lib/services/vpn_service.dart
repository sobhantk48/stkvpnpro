import 'package:flutter/foundation.dart';
import 'notification_service.dart';

enum VPNStatus { disconnected, connecting, connected, disconnecting, error }

class VpnService {
  static final VpnService _instance = VpnService._internal();
  factory VpnService() => _instance;
  VpnService._internal();

  final NotificationService _notif = NotificationService();
  VPNStatus _status = VPNStatus.disconnected;

  VPNStatus get status => _status;

  Future<void> initialize() async {
    try {
      await _notif.init();
      debugPrint('✅ VpnService و Notification مقداردهی شد');
    } catch (e) {
      debugPrint('❌ خطا در initialize: $e');
      rethrow;
    }
  }

  Future<bool> startVpn(String configJson) async {
    try {
      _status = VPNStatus.connecting;
      
      // اتصال به sing-box
      // TODO: اضافه کردن native implementation
      
      _status = VPNStatus.connected;
      await _notif.showPersistentNotification(
        '✅ VPN وصل شد',
        'اتصال برقرار است',
      );
      debugPrint('✅ VPN متصل شد');
      return true;
    } catch (e) {
      _status = VPNStatus.error;
      await _notif.showNotification(
        '❌ خطا',
        'خطا در اتصال VPN: $e',
      );
      debugPrint('❌ خطا در اتصال: $e');
      rethrow;
    }
  }

  Future<bool> stopVpn() async {
    try {
      _status = VPNStatus.disconnecting;
      
      // قطع کردن sing-box
      // TODO: اضافه کردن native implementation
      
      _status = VPNStatus.disconnected;
      await _notif.cancelAll();
      await _notif.showNotification(
        '✅ VPN قطع شد',
        'اتصال خاتمه یافت',
      );
      debugPrint('✅ VPN قطع شد');
      return true;
    } catch (e) {
      _status = VPNStatus.error;
      debugPrint('❌ خطا در قطع: $e');
      rethrow;
    }
  }

  Future<bool> toggleVpn(String configJson) async {
    if (_status == VPNStatus.connected) {
      return !(await stopVpn());
    } else {
      return await startVpn(configJson);
    }
  }

  Future<Map<String, dynamic>?> getTraffic() async {
    try {
      // TODO: دریافت ترافیک از native
      return {
        'upload': 0.0,
        'download': 0.0,
        'ping': 0,
      };
    } catch (e) {
      debugPrint('❌ خطا در دریافت ترافیک: $e');
      return null;
    }
  }
}