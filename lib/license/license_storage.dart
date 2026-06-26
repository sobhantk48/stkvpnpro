import 'package:shared_preferences/shared_preferences.dart';

class LicenseStorage {

  static Future<void>
      save(
    String token,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      "device_token",
      token,
    );
  }

  static Future<String?>
      load() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      "device_token",
    );
  }
}
