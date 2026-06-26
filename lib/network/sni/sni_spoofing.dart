class SniSpoofing {

  static bool enabled =
      false;

  static String host =
      "";

  static void configure({
    required bool active,
    required String sni,
  }) {

    enabled = active;
    host = sni;
  }
}
