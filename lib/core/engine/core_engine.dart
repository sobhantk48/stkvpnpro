abstract class CoreEngine {

  Future<String> start(
    String config,
  );

  Future<String> stop();

  Future<bool> health();
}
