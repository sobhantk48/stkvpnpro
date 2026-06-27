import 'connection_pool.dart';
import 'mux_session.dart';

class StreamManager {

  static void create() {

    ConnectionPool
        .add(

      MuxSession(

        id:
            ConnectionPool
                .count,

        active:
            true,
      ),
    );
  }
}
