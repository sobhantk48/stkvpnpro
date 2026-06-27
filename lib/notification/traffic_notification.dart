import '../traffic/traffic_statistics.dart';
import 'notification_model.dart';

class TrafficNotification {

  static NotificationModel
      build() {

    final stats =
        TrafficStatistics
            .current();

    return NotificationModel(

      title:
          "STK VPN",

      body:
          "↑ ${stats.upload} ↓ ${stats.download}",

      connected:
          true,
    );
  }
}
