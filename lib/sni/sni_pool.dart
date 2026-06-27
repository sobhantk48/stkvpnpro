import 'sni_model.dart';

class SniPool {

  static final List<SniModel>
      pool = [];

  static void add(
    SniModel sni,
  ) {

    pool.add(sni);
  }

  static void clear() {

    pool.clear();
  }
}
