import 'models/engine_state.dart';
import 'models/session_model.dart';

class SessionManager {

  static EngineState state =
      EngineState.idle;

  static SessionModel?
      currentSession;

  static Future<void>
      load(
    SessionModel session,
  ) async {

    currentSession =
        session;

    state =
        EngineState.loading;
  }

  static Future<void>
      connect() async {

    state =
        EngineState.connecting;
  }

  static Future<void>
      disconnect() async {

    state =
        EngineState.disconnected;
  }
}
