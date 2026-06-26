import 'app_model.dart';
import 'split_tunnel_state.dart';

class SplitTunnelManager {

  static SplitTunnelState
      state =
      SplitTunnelState.disabled;

  static final List<AppModel>
      apps = [];

  static void enableWhitelist() {

    state =
        SplitTunnelState.whitelist;
  }

  static void enableBlacklist() {

    state =
        SplitTunnelState.blacklist;
  }

  static void disable() {

    state =
        SplitTunnelState.disabled;
  }

  static void add(
    AppModel app,
  ) {

    apps.add(app);
  }
}
