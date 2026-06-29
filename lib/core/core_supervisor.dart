import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/models/vpn_status.dart';

/// CoreSupervisor برای مدیریت lifecycle و نظارت
class CoreSupervisor {
  static final CoreSupervisor _instance = CoreSupervisor._internal();
  
  factory CoreSupervisor() => _instance;
  CoreSupervisor._internal();

  Timer? _healthTimer;
  Timer? _trafficTimer;
  
  final ValueNotifier<VpnStatus> statusNotifier = 
      ValueNotifier(VpnStatus.disconnected);
  
  final ValueNotifier<Map<String, dynamic>> trafficNotifier = ValueNotifier({
    'upload': 0.0,
    'download': 0.0,
    'ping': 0,
    'totalUpload': 0,
    'totalDownload': 0,
  });
  
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);

  bool _isInitialized = false;

  /// مقداردهی اولیه
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      debugPrint('🔧 CoreSupervisor مقداردهی...');
      _isInitialized = true;
      debugPrint('✅ CoreSupervisor آماده');
    } catch (e) {
      debugPrint('❌ خطا: $e');
      rethrow;
    }
  }

  /// شروع نظارت سلامت
  void startHealthMonitoring({
    Duration checkInterval = const Duration(seconds: 5),
    required Future<VpnStatus> Function() statusCheck,
    required Future<void> Function(String error) onError,
  }) {
    stopHealthMonitoring();
    
    _healthTimer = Timer.periodic(checkInterval, (timer) async {
      if (!_isInitialized) return;
      
      try {
        final status = await statusCheck();
        statusNotifier.value = status;
        errorNotifier.value = null;
      } catch (e) {
        debugPrint('❌ Health Check: $e');
        statusNotifier.value = VpnStatus.error;
        errorNotifier.value = e.toString();
        await onError(e.toString());
      }
    });
  }

  /// شروع نظارت ترافیک
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
        debugPrint('❌ Traffic: $e');
      }
    });
  }

  /// متوقف کردن
  void stopHealthMonitoring() {
    _healthTimer?.cancel();
    _healthTimer = null;
  }

  void stopTrafficMonitoring() {
    _trafficTimer?.cancel();
    _trafficTimer = null;
  }

  /// پاک‌سازی کامل
  void dispose() {
    stopHealthMonitoring();
    stopTrafficMonitoring();
    statusNotifier.dispose();
    trafficNotifier.dispose();
    errorNotifier.dispose();
    _isInitialized = false;
  }
}