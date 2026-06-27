import 'admin_dashboard_engine.dart';
import 'device_manager.dart';

class AdminDashboardTest {

  static bool run() {

    DeviceManager
        .add(
            "device1");

    final dashboard =

        AdminDashboardEngine
            .build();

    return
        dashboard
            .devices == 1;
  }
}
