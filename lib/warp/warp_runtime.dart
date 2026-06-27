import 'warp_engine.dart';

class WarpRuntime {

  static bool start() {

    final config =

        WarpEngine
            .create();

    return
        config.enabled;
  }
}
