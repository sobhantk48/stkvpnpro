import 'core_engine.dart';

class SingBoxEngine implements CoreEngine {
  bool _running = false;

  @override
  Future<String> start(String configPath) async {
    _running = true;
    return "singbox started with $configPath";
  }

  @override
  Future<String> stop() async {
    _running = false;
    return "singbox stopped";
  }

  @override
  Future<String> restart(String configPath) async {
    await stop();
    return await start(configPath);
  }

  @override
  bool isRunning() => _running;
}
