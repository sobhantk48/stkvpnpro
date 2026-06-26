class KillSwitchManager {

  static bool enabled = false;

  static void enable() {
    enabled = true;
  }

  static void disable() {
    enabled = false;
  }

  static bool get active =>
      enabled;
}
