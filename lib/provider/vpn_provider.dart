import 'package:flutter/material.dart';
import '../services/vpn_service.dart';
import '../services/config_service.dart';
import '../core/core_supervisor.dart';

class VPNProvider extends ChangeNotifier {
  final VpnService _vpnService = VpnService();
  final ConfigService _configService = ConfigService();
  
  VPNStatus _status = VPNStatus.disconnected;
  String? _selectedProfileId;
  List<VPNProfile> _profiles = [];
  String? _errorMessage;
  Map<String, dynamic> _trafficData = {};

  // Getters
  VPNStatus get status => _status;
  bool get isConnected => _status == VPNStatus.connected;
  String? get selectedProfileId => _selectedProfileId;
  List<VPNProfile> get profiles => _profiles;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic> get trafficData => _trafficData;
  String? get currentProtocol => _profiles
      .cast<VPNProfile?>()
      .firstWhere((p) => p?.id == _selectedProfileId, orElse: () => null)
      ?.protocol;
  String? get currentServer => _profiles
      .cast<VPNProfile?>()
      .firstWhere((p) => p?.id == _selectedProfileId, orElse: () => null)
      ?.server;

  VPNProvider() {
    _initializeListeners();
  }

  void _initializeListeners() {
    final supervisor = CoreSupervisor();
    supervisor.statusNotifier.addListener(() {
      _status = supervisor.statusNotifier.value;
      notifyListeners();
    });
    
    supervisor.trafficNotifier.addListener(() {
      _trafficData = supervisor.trafficNotifier.value;
      notifyListeners();
    });
  }

  Future<void> initialize() async {
    try {
      await _vpnService.initialize();
      await loadProfiles();
    } catch (e) {
      _errorMessage = 'خطا در مقداردهی: $e';
      notifyListeners();
    }
  }

  /// اتصال به VPN با پروفایل
  Future<void> connect(String profileId) async {
    try {
      _errorMessage = null;
      _selectedProfileId = profileId;
      notifyListeners();

      final profile = _profiles.firstWhere((p) => p.id == profileId);
      final configJson = profile.configJson;
      
      await _vpnService.startVpn(configJson);
      await _configService.saveActiveProfile(profileId);
      
      _status = VPNStatus.connected;
      debugPrint('✅ اتصال به $profileId موفق');
      
    } catch (e) {
      _status = VPNStatus.error;
      _errorMessage = 'خطا: $e';
      debugPrint('❌ خطا در اتصال: $e');
    }
    notifyListeners();
  }

  /// قطع اتصال
  Future<void> disconnect() async {
    try {
      _errorMessage = null;
      await _vpnService.stopVpn();
      await _configService.saveActiveProfile(null);
      _status = VPNStatus.disconnected;
      _selectedProfileId = null;
      debugPrint('✅ اتصال قطع شد');
    } catch (e) {
      _status = VPNStatus.error;
      _errorMessage = 'خطا در قطع: $e';
      debugPrint('❌ خطا در قطع: $e');
    }
    notifyListeners();
  }

  /// بارگذاری پروفایل‌ها
  Future<void> loadProfiles() async {
    try {
      _errorMessage = null;
      _profiles = await _configService.loadProfiles();
      
      final activeId = await _configService.loadActiveProfile();
      _selectedProfileId = activeId;
      
      debugPrint('✅ ${_profiles.length} پروفایل بارگذاری شد');
      notifyListeners();
    } catch (e) {
      _errorMessage = 'خطا در بارگذاری پروفایل‌ها: $e';
      debugPrint('❌ $_errorMessage');
      notifyListeners();
    }
  }

  /// اضافه کردن پروفایل
  Future<void> addProfile(VPNProfile profile) async {
    try {
      _errorMessage = null;
      _profiles.add(profile);
      await _configService.saveProfiles(_profiles);
      notifyListeners();
      debugPrint('✅ پروفایل ${profile.name} اضافه شد');
    } catch (e) {
      _errorMessage = 'خطا: $e';
      notifyListeners();
    }
  }

  /// حذف پروفایل
  Future<void> deleteProfile(String profileId) async {
    try {
      _errorMessage = null;
      _profiles.removeWhere((p) => p.id == profileId);
      
      if (_selectedProfileId == profileId) {
        await disconnect();
      }
      
      await _configService.saveProfiles(_profiles);
      notifyListeners();
      debugPrint('✅ پروفایل حذف شد');
    } catch (e) {
      _errorMessage = 'خطا: $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}