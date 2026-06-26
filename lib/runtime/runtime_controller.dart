import 'config/runtime_config.dart';
import 'state/runtime_state.dart';

class RuntimeController {

  static RuntimeState
      state =
      RuntimeState.idle;

  static RuntimeConfig?
      currentConfig;

  static Future<void>
      prepare(
    RuntimeConfig config,
  ) async {

    currentConfig =
        config;

    state =
        RuntimeState.idle;
  }

  static Future<void>
      start() async {

    state =
        RuntimeState.starting;
  }

  static Future<void>
      stop() async {

    state =
        RuntimeState.stopped;
  }
}
