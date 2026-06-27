import 'dashboard_statistics.dart';
import 'protocol_status.dart';

class DashboardTest {

  static bool run() {

    ProtocolStatus
        .set(
            "vless");

    final data =

        DashboardStatistics
            .current();

    return
        data.protocol ==
        "vless";
  }
}
