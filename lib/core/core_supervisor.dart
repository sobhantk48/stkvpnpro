import 'dart:async';
import 'controller.dart';

class CoreSupervisor {
  static Timer? _healthTimer;
  static bool _isRunning = false;

  static void startMonitor({
    required Future<String> Function() restartCallback,
  }) {
    stopMonitor();

    _healthTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        if (!_isRunning) {
          _isRunning = true;
          final res = await restartCallback();
          if (res.contains('Error') || res == "Failed") {
            _isRunning = false;
          }
          return;
        }

        final status = await restartCallback();
        if (status.contains('Error') || status == "Failed") {
          _isRunning = false;
          await restartCallback();
        }
      } catch (e) {
        print('⚠️ Supervisor error: $e');
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
