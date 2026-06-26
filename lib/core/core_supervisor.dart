import 'dart:async';
import 'package:v2ray_stk/core/controller.dart';

class CoreSupervisor {
  static Timer? _healthTimer;
  static bool _isRunning = false;

  static void startMonitor({
    required Future<String> Function() restartCallback,
  }) {
    stopMonitor();

    _healthTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final logs = CoreController.getLogs();

      // اگر core dead شد → restart
      if (!_isRunning) {
        _isRunning = true;
        return;
      }

      try {
        final res = await restartCallback();

        if (res != "Started") {
          _isRunning = false;
          await restartCallback();
        }

      } catch (_) {
        _isRunning = false;
        await restartCallback();
      }
    });
  }

  static void setRunning(bool value) {
    _isRunning = value;
  }

  static void stopMonitor() {
    _healthTimer?.cancel();
    _healthTimer = null;
    _isRunning = false;
  }
}
