import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _keyPassword = 'admin_password';
  static const String _keyLanguage = 'language';
  static const String _keyCore = 'vpn_core'; // 'singbox' یا 'v2ray'

  static final _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  // ---------- رمز عبور ----------
  static Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  static Future<String> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword) ?? '1234';
  }

  static Future<bool> changePassword(String oldPassword, String newPassword) async {
    final current = await getPassword();
    if (current != oldPassword) return false;
    await savePassword(newPassword);
    return true;
  }

  // ---------- زبان ----------
  static Future<void> saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, lang);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'fa';
  }

  // ---------- هسته VPN ----------
  static Future<void> saveCore(String core) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCore, core);
  }

  static Future<String> getCore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCore) ?? 'v2ray'; // پیش‌فرض V2Ray
  }
}
