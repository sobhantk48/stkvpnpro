import 'mux_engine.dart';
import 'stream_manager.dart';

class MuxTest {

  static bool run() {

    StreamManager
        .create();

    StreamManager
        .create();

    return
        MuxEngine
            .active;
  }
}
