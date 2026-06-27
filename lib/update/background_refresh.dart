import 'update_engine.dart';

class BackgroundRefresh {

  static bool run() {

    return UpdateEngine
        .update();
  }
}
