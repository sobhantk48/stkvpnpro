import 'session_history.dart';

class ConnectionHistory {

  static int count() {

    return SessionHistory
        .sessions
        .length;
  }
}
