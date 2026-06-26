import 'core_engine.dart';

class XrayEngine
    implements CoreEngine {

  @override
  Future<String> start(
    String config,
  ) async {

    return "xray started";
  }

  @override
  Future<String> stop()
  async {

    return "xray stopped";
  }

  @override
  Future<bool> health()
  async {

    return true;
  }
}
