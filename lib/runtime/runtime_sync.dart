import '../ui/connection/vpn_connection_controller.dart';
import '../ui/connection/vpn_connection_state.dart';

class RuntimeSync {

  static void syncConnected() {

    VpnConnectionController
        .state =
        VpnConnectionState
            .connected;
  }

  static void syncDisconnected() {

    VpnConnectionController
        .state =
        VpnConnectionState
            .disconnected;
  }
}
