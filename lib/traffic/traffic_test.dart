import 'traffic_counter.dart';
import 'traffic_monitor.dart';

class TrafficTest {

  static String run() {

    TrafficCounter
        .addUpload(
            1000);

    TrafficCounter
        .addDownload(
            2000);

    return TrafficMonitor
        .summary();
  }
}
