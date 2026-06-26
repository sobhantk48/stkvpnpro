import 'core_engine.dart';

class SingboxEngine
    implements CoreEngine {

  @override
  Future<String> start(
    String config,
  ) async {

    return "sing-box started";
  }

  @override
  Future<String> stop()
  async {

    return "sing-box stopped";
  }

  @override
  Future<bool> health()
  async {

    return true;
  }
}
