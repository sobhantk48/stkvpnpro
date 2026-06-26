import 'kill_switch_state.dart';

class KillSwitchManager {

  static KillSwitchState
      state =
      KillSwitchState.disabled;

  static void enable() {

    state =
        KillSwitchState.enabled;
  }

  static void disable() {

    state =
        KillSwitchState.disabled;
  }

  static void activate() {

    state =
        KillSwitchState.active;
  }

  static bool get isEnabled {

    return state !=
        KillSwitchState.disabled;
  }
}
