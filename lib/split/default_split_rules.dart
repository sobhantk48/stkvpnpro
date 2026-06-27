import 'split_engine.dart';
import 'split_model.dart';

class DefaultSplitRules {

  static void init() {

    SplitEngine.addRule(

      const SplitModel(

        packageName: "com.example.youtube",

        useVpn: false,
      ),
    );

    SplitEngine.addRule(

      const SplitModel(

        packageName: "com.example.browser",

        useVpn: true,
      ),
    );
  }
}
