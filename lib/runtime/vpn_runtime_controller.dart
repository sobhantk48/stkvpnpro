import '../ui/connection/vpn_connection_controller.dart';
import '../ui/connection/vpn_connection_state.dart';
import 'libbox_bridge.dart';
import 'runtime_manager.dart';

class VpnRuntimeController {

  static Future<void>
      connect() async {

    VpnConnectionController
        .state =
        VpnConnectionState
            .connecting;

    try {

      await LibboxBridge
          .initialize();

      await LibboxBridge
          .startVpn();

      RuntimeManager
          .start();

      VpnConnectionController
          .state =
          VpnConnectionState
              .connected;

    } catch (_) {

      VpnConnectionController
          .state =
          VpnConnectionState
              .disconnected;
    }
  }

  static Future<void>
      disconnect() async {

    await LibboxBridge
        .stopVpn();

    RuntimeManager
        .stop();

    VpnConnectionController
        .state =
        VpnConnectionState
            .disconnected;
  }
}
