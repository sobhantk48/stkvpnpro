import 'runtime_state.dart';

class RuntimeManager {

  static RuntimeState
      state =
      RuntimeState
          .stopped;

  static void start() {

    state =
        RuntimeState
            .running;
  }

  static void stop() {

    state =
        RuntimeState
            .stopped;
  }

  static bool active() {

    return state ==

        RuntimeState
            .running;
  }
}
