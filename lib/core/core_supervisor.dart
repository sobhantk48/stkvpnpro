import 'dart:async';
import 'package:flutter/foundation.dart';
import 'controller.dart';

class CoreSupervisor {
  static Timer? _healthTimer;
  static bool _isRunning = false;
  static ValueNotifier<String> statusNotifier = ValueNotifier<String>('Disconnected');
  static ValueNotifier<Map<String, dynamic>> trafficNotifier = ValueNotifier<Map<String, dynamic>>({
    'upload': 0,
    'download': 0,
    'ping': 0,
  });

  /// شروع نظارت بر سلامت هسته
  static void startMonitor({
    required Future<String> Function() restartCallback,
    required Future<void> Function() onCriticalFailure,
  }) {
    stopMonitor();

    _healthTimer = Timer.periodic(const Duration(seconds: 4), (timer) async {
      if (!_isRunning) return;

      try {
        final result = await restartCallback();

        if (result.toLowerCase().contains('error') || result == "Failed") {
          debugPrint('⚠️ Core health check failed, restarting...');
          _isRunning = false;
          await restartCallback();
        } else {
          _isRunning = true;
          statusNotifier.value = 'Connected';
        }
      } catch (e, stack) {
        debugPrint('❌ Core Supervisor Error: $e');
        _isRunning = false;
        statusNotifier.value = 'Error';

        if (e.toString().contains('permission') || 
            e.toString().contains('native')) {
          await onCriticalFailure();
        }
      }
    });
  }

  static void setRunning(bool value) {
    _isRunning = value;
    statusNotifier.value = value ? 'Connected' : 'Disconnected';
  }

  static void stopMonitor() {
    _healthTimer?.cancel();
    _healthTimer = null;
    _isRunning = false;
    statusNotifier.value = 'Disconnected';
  }

  static void updateTraffic(int upload, int download, int ping) {
    trafficNotifier.value = {
      'upload': upload,
      'download': download,
      'ping': ping,
    };
  }

  // پاک‌سازی منابع
  static void dispose() {
    stopMonitor();
    statusNotifier.dispose();
    trafficNotifier.dispose();
  }
}