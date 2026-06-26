import 'chain_manager.dart';
import 'hop_model.dart';
import 'multihop_session.dart';

class MultiHopTest {

  static bool run() {

    ChainManager.clear();

    ChainManager.add(

      const HopModel(

        protocol:
            "vless",

        server:
            "a.com",

        port:
            443,
      ),
    );

    ChainManager.add(

      const HopModel(

        protocol:
            "tuic",

        server:
            "b.com",

        port:
            443,
      ),
    );

    return MultiHopSession
        .start();
  }
}
