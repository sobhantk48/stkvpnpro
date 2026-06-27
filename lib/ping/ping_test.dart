import 'fastest_server.dart';
import 'ping_model.dart';

class PingTest {

  static bool run() {

    final best =

        FastestServer
            .select([

      const PingModel(

        server:
            "a",

        latency:
            70,

        stability:
            95,
      ),

      const PingModel(

        server:
            "b",

        latency:
            30,

        stability:
            100,
      ),
    ]);

    return
        best?.server ==
        "b";
  }
}
