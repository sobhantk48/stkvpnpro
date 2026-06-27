class DashboardState {
  bool connected = false;
  int ping = 0;
  int upload = 0;
  int download = 0;
  String protocol = 'Disconnected';
  String status = 'Idle';
  String? lastError;

  void reset() {
    connected = false;
    ping = 0;
    upload = 0;
    download = 0;
    protocol = 'Disconnected';
    status = 'Idle';
    lastError = null;
  }
}
