import 'notification_manager.dart';

class NotificationTest {

  static bool run() {

    NotificationManager
        .show();

    return NotificationManager
        .visible;
  }
}
