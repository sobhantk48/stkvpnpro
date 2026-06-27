import '../traffic/traffic_statistics.dart';
import 'connection_state.dart';
import 'dashboard_model.dart';
import 'protocol_status.dart';

class DashboardStatistics {

  static DashboardModel
      current() {

    final traffic =

        TrafficStatistics
            .current();

    return DashboardModel(

      state:
          ConnectionState
              .connected,

      protocol:
          ProtocolStatus
              .activeProtocol,

      ping:
          0,

      upload:
          traffic.upload,

      download:
          traffic.download,
    );
  }
}
