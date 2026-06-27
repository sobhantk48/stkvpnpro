import 'mux_session.dart';

class ConnectionPool {

  static final List<MuxSession>
      sessions = [];

  static void add(
    MuxSession session,
  ) {

    sessions.add(
        session);
  }

  static int get count {

    return sessions
        .length;
  }

  static void clear() {

    sessions.clear();
  }
}
