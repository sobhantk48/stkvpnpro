import 'vault_config.dart';

class ConfigVault {

  static final List<VaultConfig>
      _configs = [];

  static void save(
    VaultConfig config,
  ) {

    _configs.add(
        config);
  }

  static int count() {

    return _configs
        .length;
  }

  static List<VaultConfig>
      internal() {

    return _configs;
  }
}
