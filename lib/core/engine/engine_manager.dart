import 'core_engine.dart';
import 'engine_type.dart';
import 'singbox_engine.dart';
import 'xray_engine.dart';

class EngineManager {

  static CoreEngine? _engine;

  static void use(
    String engine,
  ) {

    if (engine == "singbox") {
      _engine =
          SingboxEngine();
      return;
    }

    _engine =
        XrayEngine();
  }

  static Future<String>
      start(
    String config,
  ) async {

    return await
      _engine!
        .start(config);
  }

  static Future<String>
      stop() async {

    return await
      _engine!
        .stop();
  }

  static Future<bool>
      health() async {

    return await
      _engine!
        .health();
  }
}
