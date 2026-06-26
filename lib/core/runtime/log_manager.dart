class LogManager {
  static final List<String> _logs = [];

  static void add(String log) {
    _logs.add(
      "[${DateTime.now().toIso8601String()}] $log",
    );

    if (_logs.length > 500) {
      _logs.removeAt(0);
    }
  }

  static List<String> get logs =>
      List.unmodifiable(_logs);

  static void clear() {
    _logs.clear();
  }
}
