import 'app_state.dart';

class ApplicationController {

  static final AppState
      state = AppState();

  static Future<void>
      initialize() async {

    state.initialized =
        true;
  }

  static void setAdmin(
    bool value,
  ) {

    state.adminLoggedIn =
        value;
  }

  static void setVpn(
    bool value,
  ) {

    state.vpnConnected =
        value;
  }

  static void authenticate(
    bool value,
  ) {

    state.authenticated =
        value;
  }
}
