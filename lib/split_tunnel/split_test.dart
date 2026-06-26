import 'app_model.dart';
import 'routing_engine.dart';
import 'split_tunnel_manager.dart';

class SplitTest {

  static bool run() {

    SplitTunnelManager
        .enableWhitelist();

    SplitTunnelManager
        .add(

      const AppModel(

        packageName:
            "org.telegram.messenger",

        appName:
            "Telegram",
      ),
    );

    return RoutingEngine
        .allow(
            "org.telegram.messenger");
  }
}
