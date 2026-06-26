import 'hop_model.dart';

class ChainManager {

  static final List<HopModel>
      chain = [];

  static void add(
    HopModel hop,
  ) {

    chain.add(hop);
  }

  static void clear() {

    chain.clear();
  }

  static bool get enabled {

    return chain.length > 1;
  }
}
