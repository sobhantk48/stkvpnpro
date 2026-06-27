import 'sni_pool.dart';

class SniSelector {

  static String?
      select() {

    if (SniPool
        .pool
        .isEmpty) {

      return null;
    }

    return SniPool
        .pool
        .first
        .host;
  }
}
