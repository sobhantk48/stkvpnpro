class AnalyticsEngine {

  static final List<String>
      events = [];

  static void log(
    String event,
  ) {

    events.add(event);
  }

  static int count() {

    return events.length;
  }
}
