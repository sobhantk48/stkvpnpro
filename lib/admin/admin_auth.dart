import 'admin_password.dart';
import 'admin_session.dart';

class AdminAuth {

  static Future<bool>
      login(
    String password,
  ) async {

    final stored =

        await AdminPassword
            .load();

    if (stored ==
        password) {

      AdminSession
          .login();

      return true;
    }

    return false;
  }
}
