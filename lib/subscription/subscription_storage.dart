import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionStorage {

  static Future<void>
      save(
    String url,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      "subscription",
      url,
    );
  }

  static Future<String?>
      load() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      "subscription",
    );
  }
}
