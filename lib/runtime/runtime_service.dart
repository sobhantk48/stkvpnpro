import 'runtime_manager.dart';

class RuntimeService {

  static bool start() {

    RuntimeManager
        .start();

    return true;
  }

  static bool stop() {

    RuntimeManager
        .stop();

    return true;
  }
}
