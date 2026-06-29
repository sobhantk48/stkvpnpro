import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ConfigService {
  static const String _keyProfiles = 'vpn_profiles';
  static const String _keyActiveProfile = 'active_profile';

  static Future<List<VPNProfile>> loadProfiles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_keyProfiles);
      if (json == null) return [];
      
      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((e) => VPNProfile.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      debugPrint('❌ خطا در بارگذاری پروفایل‌ها: $e');
      return [];
    }
  }

  static Future<void> saveProfiles(List<VPNProfile> profiles) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = jsonEncode(profiles.map((p) => p.toJson()).toList());
      await prefs.setString(_keyProfiles, json);
      debugPrint('✅ پروفایل‌ها ذخیره شدند');
    } catch (e) {
      debugPrint('❌ خطا در ذخیره پروفایل‌ها: $e');
      rethrow;
    }
  }

  static Future<String?> loadActiveProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyActiveProfile);
    } catch (e) {
      debugPrint('❌ خطا در بارگذاری پروفایل فعال: $e');
      return null;
    }
  }

  static Future<void> saveActiveProfile(String? profileId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (profileId == null) {
        await prefs.remove(_keyActiveProfile);
      } else {
        await prefs.setString(_keyActiveProfile, profileId);
      }
      debugPrint('✅ پروفایل فعال ذخیره شد');
    } catch (e) {
      debugPrint('❌ خطا در ذخیره پروفایل فعال: $e');
      rethrow;
    }
  }
}

class VPNProfile {
  final String id;
  final String name;
  final String protocol;
  final String server;
  final String configJson;
  final DateTime createdAt;

  VPNProfile({
    required this.id,
    required this.name,
    required this.protocol,
    required this.server,
    required this.configJson,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'protocol': protocol,
    'server': server,
    'config': configJson,
    'createdAt': createdAt.toIso8601String(),
  };

  factory VPNProfile.fromJson(Map<String, dynamic> json) {
    return VPNProfile(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      protocol: json['protocol'] ?? 'VLESS',
      server: json['server'] ?? '',
      configJson: json['config'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}