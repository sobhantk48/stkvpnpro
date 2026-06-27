import 'package:flutter/services.dart';
import '../ui/status/vpn_status_controller.dart';

class VpnStatusBridge {

  static const MethodChannel _ch =
      MethodChannel('stk_vpn/native');

  static Future<void> connect() async {

    VpnStatusController.setConnecting();

    await _ch.invokeMethod('startVpn');

    VpnStatusController.setConnected();
  }

  static Future<void> disconnect() async {

    await _ch.invokeMethod('stopVpn');

    VpnStatusController.setDisconnected();
  }
}
