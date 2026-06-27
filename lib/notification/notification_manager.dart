import 'notification_state.dart';

class NotificationManager {

  static NotificationState
      state =
      NotificationState.hidden;

  static void show() {

    state =
        NotificationState.visible;
  }

  static void hide() {

    state =
        NotificationState.hidden;
  }

  static bool get visible {

    return state ==
        NotificationState.visible;
  }
}
