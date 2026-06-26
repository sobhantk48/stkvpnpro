class SmartRouter {

  static String select({

    required int ping,

    required bool stable,

  }) {

    if (stable &&
        ping < 80) {
      return "reality";
    }

    if (ping < 150) {
      return "hysteria";
    }

    return "wireguard";
  }
}
