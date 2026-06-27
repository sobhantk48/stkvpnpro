import 'traffic_statistics.dart';

class TrafficMonitor {

  static String
      summary() {

    final stats =

        TrafficStatistics
            .current();

    return
        "UP=${stats.upload} "
        "DOWN=${stats.download}";
  }
}
