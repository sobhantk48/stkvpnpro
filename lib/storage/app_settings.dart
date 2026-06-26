import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {

  static Future<void> setLanguage(
    String language,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      'language',
      language,
    );
  }

  static Future<String>
      getLanguage() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
          'language',
        ) ??
        'fa';
  }
}
