import 'core_engine.dart';
import 'singbox_engine.dart';
import 'xray_engine.dart';

class EngineManager {
  static CoreEngine? _engine;

  static void use(String type) {
    if (type == "singbox") {
      _engine = SingBoxEngine();
    } else {
      _engine = XrayEngine();
    }
  }

  static Future<String> start(String configPath) async {
    return _engine?.start(configPath) ?? "No Engine Selected";
  }

  static Future<String> stop() async {
    return _engine?.stop() ?? "No Engine Selected";
  }

  static Future<String> restart(String configPath) async {
    return _engine?.restart(configPath) ?? "No Engine Selected";
  }

  static bool isRunning() {
    return _engine?.isRunning() ?? false;
  }
}
