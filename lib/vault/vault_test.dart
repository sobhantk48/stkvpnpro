import 'config_vault.dart';
import 'protected_repository.dart';

class VaultTest {

  static bool run() {

    ProtectedRepository
        .add(

      "1",

      "vless://test",
    );

    return
        ConfigVault
            .count() > 0;
  }
}
