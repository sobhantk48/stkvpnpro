import 'vpn_connection_controller.dart';
import 'vpn_connection_state.dart';

class ConnectionTest {

  static bool run() {

    VpnConnectionController
        .connect();

    return

        VpnConnectionController
            .state

        ==

        VpnConnectionState
            .connected;
  }
}
