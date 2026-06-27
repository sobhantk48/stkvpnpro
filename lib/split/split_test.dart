import 'split_engine.dart';

class SplitTest {

  static bool run() {

    return SplitEngine
        .shouldUseVpn(
            "com.example.browser"
        ) == true;
  }
}
