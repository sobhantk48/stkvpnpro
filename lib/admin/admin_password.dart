import 'package:shared_preferences/shared_preferences.dart';

class AdminPassword {

  static const String
      _key =
      "admin_password";

  static Future<void>
      save(
    String password,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      _key,
      password,
    );
  }

  static Future<String?>
      load() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      _key,
    );
  }
}
