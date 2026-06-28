import 'package:flutter/material.dart';
import '../services/native_service.dart';

/// Provider برای مدیریت وضعیت VPN
class VPNProvider extends ChangeNotifier {
  bool _isConnected = false;
  String _connectionStatus = 'disconnected';
  String? _selectedProfile;
  List<String> _profiles = [];
  String? _errorMessage;

  // Getters
  bool get isConnected => _isConnected;
  String get connectionStatus => _connectionStatus;
  String? get selectedProfile => _selectedProfile;
  List<String> get profiles => _profiles;
  String? get errorMessage => _errorMessage;

  /// اتصال به VPN
  Future<void> connect(String profileName) async {
    try {
      _errorMessage = null;
      _connectionStatus = 'connecting';
      notifyListeners();

      // فراخوانی سرویس native برای اتصال
      final result = await NativeService.connect(profileName);
      
      if (result) {
        _isConnected = true;
        _selectedProfile = profileName;
        _connectionStatus = 'connected';
        print('✅ اتصال به $profileName موفق بود');
      } else {
        _isConnected = false;
        _connectionStatus = 'failed';
        _errorMessage = 'خطا در اتصال به VPN';
        print('❌ اتصال ناموفق');
      }
    } catch (e) {
      _isConnected = false;
      _connectionStatus = 'error';
      _errorMessage = 'خطا: $e';
      print('❌ خطا در اتصال: $e');
    }
    notifyListeners();
  }

  /// قطع اتصال از VPN
  Future<void> disconnect() async {
    try {
      _errorMessage = null;
      _connectionStatus = 'disconnecting';
      notifyListeners();

      final result = await NativeService.disconnect();
      
      if (result) {
        _isConnected = false;
        _selectedProfile = null;
        _connectionStatus = 'disconnected';
        print('✅ اتصال قطع شد');
      } else {
        _connectionStatus = 'error';
        _errorMessage = 'خطا در قطع اتصال';
        print('❌ قطع اتصال ناموفق');
      }
    } catch (e) {
      _connectionStatus = 'error';
      _errorMessage = 'خطا: $e';
      print('❌ خطا در قطع اتصال: $e');
    }
    notifyListeners();
  }

  /// دریافت وضعیت VPN
  Future<void> checkStatus() async {
    try {
      final status = await NativeService.getStatus();
      _connectionStatus = status ?? 'unknown';
      notifyListeners();
    } catch (e) {
      print('❌ خطا در دریافت وضعیت: $e');
    }
  }

  /// بارگذاری پروفایل‌ها
  Future<void> loadProfiles() async {
    try {
      final profiles = await NativeService.getProfiles();
      _profiles = profiles;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'خطا در بارگذاری پروفایل‌ها: $e';
      print('❌ $_errorMessage');
      notifyListeners();
    }
  }

  /// ذخیره پروفایل جدید
  Future<void> saveProfile(String name, String config) async {
    try {
      final result = await NativeService.saveProfile(name, config);
      if (result) {
        await loadProfiles();
        print('✅ پروفایل $name ذخیره شد');
      }
    } catch (e) {
      _errorMessage = 'خطا در ذخیره پروفایل: $e';
      print('❌ $_errorMessage');
      notifyListeners();
    }
  }

  /// حذف پروفایل
  Future<void> deleteProfile(String name) async {
    try {
      final result = await NativeService.deleteProfile(name);
      if (result) {
        await loadProfiles();
        print('✅ پروفایل $name حذف شد');
      }
    } catch (e) {
      _errorMessage = 'خطا در حذف پروفایل: $e';
      print('❌ $_errorMessage');
      notifyListeners();
    }
  }
}
