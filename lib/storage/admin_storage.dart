import 'package:shared_preferences/shared_preferences.dart';

class AdminStorage {

  static Future<void>
      savePassword(
    String password,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      'admin_password',
      password,
    );
  }

  static Future<String?>
      getPassword() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      'admin_password',
    );
  }
}
