import '../admin/admin_session.dart';
import 'config_vault.dart';
import 'vault_config.dart';

class HiddenAccess {

  static List<VaultConfig>
      read() {

    if (!AdminSession
        .isAdmin) {

      return [];
    }

    return ConfigVault
        .internal();
  }
}
