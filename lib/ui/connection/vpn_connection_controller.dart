import 'vpn_connection_state.dart';

class VpnConnectionController {

  static VpnConnectionState
      state =
      VpnConnectionState
          .disconnected;

  static void connect() {

    state =
        VpnConnectionState
            .connected;
  }

  static void disconnect() {

    state =
        VpnConnectionState
            .disconnected;
  }
}
