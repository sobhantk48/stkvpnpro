import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ConfigService {
  static const String _keyConfigs = 'configs';
  static const String _keyActiveConfig = 'active_config';

  static Future<void> saveConfigs(List<Map<String, String>> configs) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(configs);
    await prefs.setString(_keyConfigs, json);
  }

  static Future<List<Map<String, String>>> loadConfigs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyConfigs);
    if (json == null) return [];
    try {
      final List<dynamic> list = jsonDecode(json);
      return list.map((e) => Map<String, String>.from(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveActiveConfig(String? config) async {
    final prefs = await SharedPreferences.getInstance();
    if (config == null) {
      await prefs.remove(_keyActiveConfig);
    } else {
      await prefs.setString(_keyActiveConfig, config);
    }
  }

  static Future<String?> loadActiveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyActiveConfig);
  }
}
