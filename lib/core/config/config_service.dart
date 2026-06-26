import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  static const _key = "configs";
  static const _active = "active";

  static Future<void> saveConfigs(List<Map<String, String>> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, data.toString());
  }

  static Future<List<Map<String, String>>> loadConfigs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    return [];
  }

  static Future<void> saveActiveConfig(String? config) async {
    final prefs = await SharedPreferences.getInstance();
    if (config == null) {
      prefs.remove(_active);
    } else {
      prefs.setString(_active, config);
    }
  }

  static Future<String?> loadActiveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_active);
  }
}
