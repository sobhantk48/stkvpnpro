abstract class CoreEngine {
  Future<String> start(String configPath);
  Future<String> stop();
  Future<String> restart(String configPath);
  bool isRunning();
}
