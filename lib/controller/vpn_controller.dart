import '../runtime/vpn_status_bridge.dart';

class VpnController {

  static Future<void> connect() async {

    await VpnStatusBridge.connect();
  }

  static Future<void> disconnect() async {

    await VpnStatusBridge.disconnect();
  }
}
