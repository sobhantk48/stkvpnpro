import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:v2ray_stk/services/vpn_service_interface.dart';

class V2rayService implements VpnService {
  final V2Ray _v2ray = V2Ray();
  bool _isConnected = false;

  @override
  bool get isConnected => _isConnected;

  @override
  Future<void> startVpn(String config) async {
    try {
      await _v2ray.startV2Ray(
        remark: 'V2RAY stk',
        config: config,
        useSystemProxy: false,
      );
      _isConnected = true;
      print('✅ V2Ray متصل شد');
    } catch (e) {
      print('❌ خطا در اتصال V2Ray: $e');
      _isConnected = false;
      rethrow;
    }
  }

  @override
  Future<void> stopVpn() async {
    try {
      await _v2ray.stopV2Ray();
      _isConnected = false;
      print('❌ V2Ray قطع شد');
    } catch (e) {
      print('❌ خطا در قطع V2Ray: $e');
      rethrow;
    }
  }

  @override
  Future<void> toggleVpn(String config) async {
    if (_isConnected) {
      await stopVpn();
    } else {
      await startVpn(config);
    }
  }

  @override
  Future<String?> getStatus() async {
    try {
      return await _v2ray.getStatus();
    } catch (e) {
      return null;
    }
  }
}
