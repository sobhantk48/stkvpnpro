class BestProtocolSelector {

  static String choose({

    required int ping,

    required bool stable,

    required bool local,

  }) {

    if (stable && ping < 100) {
      return "reality";
    }

    if (stable) {
      return "hysteria";
    }

    if (local) {
      return "wireguard";
    }

    return "vless";
  }
}
