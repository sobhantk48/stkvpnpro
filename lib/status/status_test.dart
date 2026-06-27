import 'status_engine.dart';

class StatusTest {

  static bool run() {

    StatusEngine
        .setConnected();

    return StatusEngine
        .isConnected();
  }
}
