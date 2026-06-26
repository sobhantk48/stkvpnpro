import 'vpn_config.dart';

class ConfigStorage {

  static final List<VpnConfig>
      _configs = [];

  static List<VpnConfig> get all =>
      List.unmodifiable(_configs);

  static bool add(
    VpnConfig config,
  ) {

    if (_configs.length >= 10) {
      return false;
    }

    _configs.add(config);
    return true;
  }

  static void remove(
    String id,
  ) {
    _configs.removeWhere(
      (e) => e.id == id,
    );
  }

  static void clear() {
    _configs.clear();
  }
}
