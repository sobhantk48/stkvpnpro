import 'vpn_status.dart';

class StatusEngine {

  static VpnStatus
      status =
      VpnStatus.disconnected;

  static void setConnecting() {

    status =
        VpnStatus.connecting;
  }

  static void setConnected() {

    status =
        VpnStatus.connected;
  }

  static void setDisconnected() {

    status =
        VpnStatus.disconnected;
  }

  static bool isConnected() {

    return status ==
        VpnStatus.connected;
  }
}
