import 'dart:async';
import 'package:flutter/foundation.dart';

/// وضعیت‌های ممکن VPN
enum VPNStatus { disconnected, connecting, connected, disconnecting, error }

/// CoreSupervisor برای مدیریت چرخه حیات و نظارت بر VPN
class CoreSupervisor {
  static final CoreSupervisor _instance = CoreSupervisor._internal();
  
  factory CoreSupervisor() => _instance;
  CoreSupervisor._internal();

  Timer? _healthTimer;
  Timer? _trafficTimer;
  
  final ValueNotifier<VPNStatus> statusNotifier = ValueNotifier(VPNStatus.disconnected);
  final ValueNotifier<String> statusTextNotifier = ValueNotifier('قطع شده');
  final ValueNotifier<Map<String, dynamic>> trafficNotifier = ValueNotifier({
    'upload': 0.0,
    'download': 0.0,
    'ping': 0,
    'totalUpload': 0,
    'totalDownload': 0,
  });
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);

  bool _isInitialized = false;

  /// مقداردهی اولیه سرویس‌ها
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      debugPrint('🔧 CoreSupervisor مقداردهی شروع شد...');
      _isInitialized = true;
      debugPrint('✅ CoreSupervisor آماده است');
    } catch (e, stack) {
      debugPrint('❌ خطا در initialize: $e\n$stack');
      errorNotifier.value = 'خطا در مقداردهی: $e';
      rethrow;
    }
  }

  /// شروع نظارت بر سلامت VPN
  void startHealthMonitoring({
    Duration checkInterval = const Duration(seconds: 5),
    required Future<VPNStatus> Function() statusCheck,
    required Future<void> Function(String error) onError,
  }) {
    stopHealthMonitoring();
    
    _healthTimer = Timer.periodic(checkInterval, (timer) async {
      if (!_isInitialized) return;
      
      try {
        final status = await statusCheck();
        _updateStatus(status);
        errorNotifier.value = null;
      } catch (e) {
        debugPrint('❌ Health Check Error: $e');
        _updateStatus(VPNStatus.error);
        errorNotifier.value = 'خطا در نظارت: $e';
        await onError(e.toString());
      }
    });
  }

  /// نظارت بر ترافیک
  void startTrafficMonitoring({
    Duration updateInterval = const Duration(seconds: 1),
    required Future<Map<String, dynamic>> Function() trafficFetcher,
  }) {
    stopTrafficMonitoring();
    
    _trafficTimer = Timer.periodic(updateInterval, (timer) async {
      try {
        final traffic = await trafficFetcher();
        trafficNotifier.value = {
          ...trafficNotifier.value,
          ...traffic,
        };
      } catch (e) {
        debugPrint('❌ Traffic Monitoring Error: $e');
      }
    });
  }

  /// به‌روزرسانی وضعیت
  void _updateStatus(VPNStatus status) {
    statusNotifier.value = status;
    statusTextNotifier.value = _getStatusText(status);
  }

  /// دریافت متن وضعیت
  String _getStatusText(VPNStatus status) {
    switch (status) {
      case VPNStatus.disconnected:
        return 'قطع شده';
      case VPNStatus.connecting:
        return 'در حال اتصال...';
      case VPNStatus.connected:
        return 'متصل';
      case VPNStatus.disconnecting:
        return 'در حال قطع...';
      case VPNStatus.error:
        return 'خطا';
    }
  }

  /// دستی تعیین وضعیت
  void setStatus(VPNStatus status) {
    _updateStatus(status);
  }

  /// به‌روزرسانی ترافیک
  void updateTraffic({
    required double upload,
    required double download,
    required int ping,
    int? totalUpload,
    int? totalDownload,
  }) {
    trafficNotifier.value = {
      'upload': upload,
      'download': download,
      'ping': ping,
      'totalUpload': totalUpload ?? trafficNotifier.value['totalUpload'] ?? 0,
      'totalDownload': totalDownload ?? trafficNotifier.value['totalDownload'] ?? 0,
    };
  }

  /// متوقف کردن نظارت سلامت
  void stopHealthMonitoring() {
    _healthTimer?.cancel();
    _healthTimer = null;
  }

  /// متوقف کردن نظارت ترافیک
  void stopTrafficMonitoring() {
    _trafficTimer?.cancel();
    _trafficTimer = null;
  }

  /// پاک‌سازی کامل منابع
  void dispose() {
    stopHealthMonitoring();
    stopTrafficMonitoring();
    statusNotifier.dispose();
    statusTextNotifier.dispose();
    trafficNotifier.dispose();
    errorNotifier.dispose();
    _isInitialized = false;
  }
}