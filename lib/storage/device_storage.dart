import 'package:shared_preferences/shared_preferences.dart';

class DeviceStorage {

  static Future<void>
      saveToken(
    String token,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      'device_token',
      token,
    );
  }

  static Future<String?>
      getToken() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      'device_token',
    );
  }
}
