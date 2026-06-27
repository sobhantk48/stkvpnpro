class NotificationEngine {

  static String message = "";

  static void update(
    String msg,
  ) {

    message = msg;
  }

  static String current() {

    return message;
  }
}
