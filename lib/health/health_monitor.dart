import 'health_check.dart';

class HealthMonitor {

  static bool healthy() {

    return HealthCheck
        .check();
  }
}
