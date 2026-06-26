import '../../vpn/models/vpn_status.dart';

class AndroidVpnRuntime {

  static VpnStatus status =
      VpnStatus.disconnected;

  static Future<void>
      connect() async {

    status =
      VpnStatus.connecting;
  }

  static Future<void>
      connected() async {

    status =
      VpnStatus.connected;
  }

  static Future<void>
      disconnect() async {

    status =
      VpnStatus.disconnected;
  }

  static Future<void>
      error() async {

    status =
      VpnStatus.error;
  }
}
