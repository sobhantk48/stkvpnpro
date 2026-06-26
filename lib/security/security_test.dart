import 'kill_switch_manager.dart';

class SecurityTest {

  static bool run() {

    KillSwitchManager
        .enable();

    return
        KillSwitchManager
            .isEnabled;
  }
}
