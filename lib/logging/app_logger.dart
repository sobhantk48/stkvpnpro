import 'log_level.dart';

class AppLogger {

  static final List<String> logs = [];

  static void log({
    required LogLevel level,
    required String message,
  }) {

    logs.add(
      "[${level.name}] $message",
    );
  }

  static void clear() {
    logs.clear();
  }
}
