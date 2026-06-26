import 'auto_selector.dart';
import 'protocol_score.dart';

class SmartTest {

  static String run() {

    return AutoSelector
        .select([

      const ProtocolScore(

        protocol:
            "vless",

        ping:
            70,

        stability:
            95,

        speed:
            100,

        location:
            90,
      ),

      const ProtocolScore(

        protocol:
            "tuic",

        ping:
            40,

        stability:
            80,

        speed:
            110,

        location:
            90,
      ),
    ]);
  }
}
