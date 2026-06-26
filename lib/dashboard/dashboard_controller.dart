import 'dashboard_state.dart';

class DashboardController {

  static final DashboardState
      state = DashboardState();

  static void setConnected(
    bool value,
  ) {
    state.connected = value;
  }

  static void setPing(
    int value,
  ) {
    state.ping = value;
  }

  static void setTraffic({
    required int upload,
    required int download,
  }) {
    state.upload = upload;
    state.download = download;
  }

  static void setProtocol(
    String protocol,
  ) {
    state.protocol = protocol;
  }
}
