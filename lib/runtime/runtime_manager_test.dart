import 'runtime_manager.dart';

class RuntimeManagerTest {

  static bool run() {

    RuntimeManager
        .start();

    return
        RuntimeManager
            .active();
  }
}
