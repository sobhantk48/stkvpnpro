import 'vpn_runtime_controller.dart';

class VpnRuntimeTest {

  static Future<bool> run() async {

    await VpnRuntimeController
        .connect();

    await VpnRuntimeController
        .disconnect();

    return true;
  }
}
