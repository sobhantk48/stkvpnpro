import 'config_vault.dart';
import 'vault_config.dart';

class ProtectedRepository {

  static void add(

    String id,

    String config,

  ) {

    ConfigVault.save(

      VaultConfig(

        id: id,

        config: config,
      ),
    );
  }
}
