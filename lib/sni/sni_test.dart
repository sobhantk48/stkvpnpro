import 'sni_model.dart';
import 'sni_pool.dart';
import 'sni_selector.dart';

class SniTest {

  static bool run() {

    SniPool.clear();

    SniPool.add(

      const SniModel(

        host:
            "google.com",
      ),
    );

    return

        SniSelector
            .select()

        ==

        "google.com";
  }
}
