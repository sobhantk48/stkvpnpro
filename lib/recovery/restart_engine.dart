import 'crash_recovery.dart';

class RestartEngine {

  static bool restart() {

    return CrashRecovery
        .recover();
  }
}
