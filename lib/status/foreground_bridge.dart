import 'status_engine.dart';

class ForegroundBridge {

  static void start() {

    StatusEngine
        .setConnecting();
  }

  static void stop() {

    StatusEngine
        .setDisconnected();
  }

  static void success() {

    StatusEngine
        .setConnected();
  }
}
