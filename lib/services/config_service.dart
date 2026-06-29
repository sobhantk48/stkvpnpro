import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../config/vpn_config.dart';

class ConfigService {
  static const String _keyConfigs = 'vpn_configs';
  static const String _keyActiveConfig = 'active_config';

  /// بارگذاری تمام پروفایل‌ها
  static Future<List<VpnConfig>> loadConfigs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_keyConfigs);
      if (json == null) return [];
      
      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((e) => VpnConfig.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      debugPrint('❌ خطا در بارگذاری کانفیگ‌ها: $e');
      return [];
    }
  }

  /// ذخیره تمام پروفایل‌ها
  static Future<void> saveConfigs(List<VpnConfig> configs) async {
    try {
      if (configs.length > 10) {
        throw Exception('حداکثر 10 پروفایل مجاز است');
      }
      
      final prefs = await SharedPreferences.getInstance();
      final json = jsonEncode(configs.map((c) => c.toJson()).toList());
      await prefs.setString(_keyConfigs, json);
      debugPrint('✅ ${configs.length} پروفایل ذخیره شد');
    } catch (e) {
      debugPrint('❌ خطا در ذخیره: $e');
      rethrow;
    }
  }

  /// بارگذاری پروفایل فعال
  static Future<String?> loadActiveConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyActiveConfig);
    } catch (e) {
      debugPrint('❌ خطا: $e');
      return null;
    }
  }

  /// ذخیره پروفایل فعال
  static Future<void> saveActiveConfig(String? configId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (configId == null) {
        await prefs.remove(_keyActiveConfig);
      } else {
        await prefs.setString(_keyActiveConfig, configId);
      }
    } catch (e) {
      debugPrint('❌ خطا: $e');
      rethrow;
    }
  }
}