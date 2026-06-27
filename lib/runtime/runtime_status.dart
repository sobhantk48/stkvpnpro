import 'runtime_manager.dart';

class RuntimeStatus {

  static String text() {

    return RuntimeManager
            .active()

        ? "running"

        : "stopped";
  }
}
