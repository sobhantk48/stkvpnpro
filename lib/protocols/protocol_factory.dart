class ProtocolFactory {

  static String detect(
    String config,
  ) {

    if (config.contains(
      "reality",
    )) {
      return "reality";
    }

    if (config.contains(
      "hysteria",
    )) {
      return "hysteria";
    }

    if (config.contains(
      "tuic",
    )) {
      return "tuic";
    }

    if (config.contains(
      "warp",
    )) {
      return "warp";
    }

    return "unknown";
  }
}
