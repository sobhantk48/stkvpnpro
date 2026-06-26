import '../engine/engine_manager.dart';

class EngineHealthMonitor {

  static Future<bool>
      check() async {

    return await
      EngineManager
          .health();
  }
}
