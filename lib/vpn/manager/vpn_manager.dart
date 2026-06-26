import '../models/vpn_status.dart';
import '../models/traffic_stats.dart';

class VpnManager {
  static VpnStatus _status =
      VpnStatus.disconnected;

  static TrafficStats _stats =
      TrafficStats.empty;

  static VpnStatus get status =>
      _status;

  static TrafficStats get stats =>
      _stats;

  static void setStatus(
    VpnStatus status,
  ) {
    _status = status;
  }

  static void updateTraffic({
    required int upload,
    required int download,
  }) {
    _stats = TrafficStats(
      upload: upload,
      download: download,
    );
  }

  static void reset() {
    _status = VpnStatus.disconnected;
    _stats = TrafficStats.empty;
  }
}
