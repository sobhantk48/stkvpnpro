import '../stats/connection_stats.dart';

class TrafficMonitor {

  static final ConnectionStats
      stats =
          ConnectionStats();

  static void update({
    required int upload,
    required int download,
  }) {

    stats.upload =
        upload;

    stats.download =
        download;
  }
}
