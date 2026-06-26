import 'split_tunnel_manager.dart';
import 'split_tunnel_state.dart';

class RoutingEngine {

  static bool allow(
    String packageName,
  ) {

    if (SplitTunnelManager
            .state ==
        SplitTunnelState
            .disabled) {

      return true;
    }

    return SplitTunnelManager
        .apps
        .any(
          (e) =>
              e.packageName ==
              packageName,
        );
  }
}
