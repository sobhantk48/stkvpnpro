import 'core_engine.dart';

class XrayEngine implements CoreEngine {
  bool _running = false;

  @override
  Future<String> start(String configPath) async {
    _running = true;
    return "xray started with $configPath";
  }

  @override
  Future<String> stop() async {
    _running = false;
    return "xray stopped";
  }

  @override
  Future<String> restart(String configPath) async {
    await stop();
    return await start(configPath);
  }

  @override
  bool isRunning() => _running;
}
