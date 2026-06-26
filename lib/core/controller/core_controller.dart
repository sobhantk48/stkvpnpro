import '../engine/engine_manager.dart';
import '../runtime/log_manager.dart';

class CoreController {

  static Future<String> start(
    String engine,
    String config,
  ) async {

    EngineManager.use(engine);

    LogManager.add(
      "Starting engine: $engine"
    );

    final result =
        await EngineManager.start(config);

    LogManager.add(result);

    return result;
  }

  static Future<String> stop() async {

    LogManager.add(
      "Stopping engine"
    );

    final result =
        await EngineManager.stop();

    LogManager.add(result);

    return result;
  }
}
