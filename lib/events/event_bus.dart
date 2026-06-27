class EventBus {

  static final List<String>
      events = [];

  static void emit(
    String event,
  ) {
    events.add(event);
  }
}
