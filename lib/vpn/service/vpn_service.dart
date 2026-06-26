import '../manager/vpn_manager.dart';
import '../models/vpn_status.dart';

class VpnService {

  static Future<void> start() async {
    VpnManager.setStatus(
      VpnStatus.connecting,
    );
  }

  static Future<void> connected() async {
    VpnManager.setStatus(
      VpnStatus.connected,
    );
  }

  static Future<void> stop() async {
    VpnManager.setStatus(
      VpnStatus.disconnected,
    );
  }

  static Future<void> error() async {
    VpnManager.setStatus(
      VpnStatus.error,
    );
  }
}
