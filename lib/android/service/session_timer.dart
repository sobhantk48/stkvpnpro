class SessionTimer {

  static DateTime?
      connectedAt;

  static void start() {
    connectedAt =
        DateTime.now();
  }

  static void stop() {
    connectedAt = null;
  }

  static Duration
      get duration {

    if (connectedAt ==
        null) {
      return Duration.zero;
    }

    return DateTime.now()
        .difference(
      connectedAt!,
    );
  }
}
