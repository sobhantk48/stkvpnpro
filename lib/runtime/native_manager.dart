import 'native_state.dart';
import 'libbox_bridge.dart';

class NativeManager {

  static NativeState
      state =
      NativeState.unloaded;

  static Future<void>
      initialize() async {

    try {

      final ok =
          await LibboxBridge
              .initialize();

      if (ok) {

        state =
            NativeState.loaded;
      } else {

        state =
            NativeState.failed;
      }

    } catch (_) {

      state =
          NativeState.failed;
    }
  }
}
