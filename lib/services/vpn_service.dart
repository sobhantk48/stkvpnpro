import 'package:flutter/foundation.dart';
import 'package:flutter_singbox_vpn/flutter_singbox_vpn.dart';
import 'notification_service.dart';
import '../core/models/vpn_status.dart';

class VpnService {
  static final VpnService _instance = VpnService._internal();
  factory VpnService() => _instance;
  VpnService._internal();

  final NotificationService _notif = NotificationService();
  final _singbox = FlutterSingboxVpn();
  
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

  Future<bool> startVpn(String configJson) async {
    try {
      _status = VpnStatus.connecting;
      
      // استفاده از flutter_singbox_vpn
      final result = await _singbox.start(
        config: configJson,
      );
      
      _status = result ? VpnStatus.connected : VpnStatus.error;
      
      if (result) {
        await _notif.showPersistentNotification(
          '✅ VPN وصل شد',
          'اتصال برقرار است',
        );
        debugPrint('✅ VPN متصل');
      } else {
        throw Exception('شروع Singbox ناموفق');
      }
      
      return result;
    } catch (e) {
      _status = VpnStatus.error;
      await _notif.showNotification('❌ خطا', 'خطا: $e');
      debugPrint('❌ خطا: $e');
      rethrow;
    }
  }

  Future<bool> stopVpn() async {
    try {
      _status = VpnStatus.disconnecting;
      
      final result = await _singbox.stop();
      
      _status = VpnStatus.disconnected;
      await _notif.cancelAll();
      await _notif.showNotification('✅ VPN قطع شد', 'اتصال خاتمه یافت');
      
      debugPrint('✅ VPN قطع شد');
      return result;
    } catch (e) {
      _status = VpnStatus.error;
      debugPrint('❌ خطا: $e');
      rethrow;
    }
  }

  Future<bool> toggleVpn(String configJson) async {
    return _status == VpnStatus.connected 
        ? await stopVpn() 
        : await startVpn(configJson);
  }

  Future<Map<String, dynamic>?> getTraffic() async {
    try {
      final traffic = await _singbox.getTraffic();
      return traffic;
    } catch (e) {
      debugPrint('❌ خطا: $e');
      return null;
    }
  }

  Future<VpnStatus?> checkStatus() async {
    try {
      final isConnected = await _singbox.isConnected();
      return isConnected ? VpnStatus.connected : VpnStatus.disconnected;
    } catch (e) {
      return null;
    }
  }
}