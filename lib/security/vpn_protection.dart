import 'kill_switch_manager.dart';

class VpnProtection {

  static void
      onVpnDisconnected() {

    if (KillSwitchManager
        .isEnabled) {

      KillSwitchManager
          .activate();
    }
  }
}
