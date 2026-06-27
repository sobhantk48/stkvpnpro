import 'package:flutter/foundation.dart';

enum VpnState {
  disconnected,
  connecting,
  connected,
}

class VpnStatusController {

  static ValueNotifier<VpnState>
      state =
      ValueNotifier(
          VpnState.disconnected
      );

  static void setConnecting() {

    state.value =
        VpnState.connecting;
  }

  static void setConnected() {

    state.value =
        VpnState.connected;
  }

  static void setDisconnected() {

    state.value =
        VpnState.disconnected;
  }
}
