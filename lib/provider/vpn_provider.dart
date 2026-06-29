import 'package:flutter/material.dart';
import '../services/vpn_service.dart';
import '../services/config_service.dart';
import '../config/vpn_config.dart';
import '../core/models/vpn_status.dart';
import '../core/core_supervisor.dart';

class VPNProvider extends ChangeNotifier {
  final VpnService _vpnService = VpnService();
  final CoreSupervisor _supervisor = CoreSupervisor();
  
  VpnStatus _status = VpnStatus.disconnected;
  String? _selectedConfigId;
  List<VpnConfig> _configs = [];
  String? _errorMessage;

  // Getters
  VpnStatus get status => _status;
  bool get isConnected => _status == VpnStatus.connected;
  String? get selectedConfigId => _selectedConfigId;
  List<VpnConfig> get configs => _configs;
  String? get errorMessage => _errorMessage;

  String? get currentProtocol {
    if (_selectedConfigId == null) return null;
    try {
      return _configs.firstWhere((c) => c.id == _selectedConfigId).protocol;
    } catch (e) {
      return null;
    }
  }

  String? get currentServer {
    if (_selectedConfigId == null) return null;
    try {
      // استخراج server از rawConfig
      return 'Server';  // TODO: Parse from config
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> get trafficData => _supervisor.trafficNotifier.value;

  VPNProvider() {
    _initializeListeners();
  }

  void _initializeListeners() {
    _supervisor.statusNotifier.addListener(() {
      _status = _supervisor.statusNotifier.value;
      notifyListeners();
    });
    
    _supervisor.trafficNotifier.addListener(() {
      notifyListeners();
    });
  }

  Future<void> initialize() async {
    try {
      await _supervisor.initialize();
      await _vpnService.initialize();
      await loadConfigs();
    } catch (e) {
      _errorMessage = 'خطا: $e';
      notifyListeners();
    }
  }

  /// اتصال
  Future<void> connect(String configId) async {
    try {
      _errorMessage = null;
      _selectedConfigId = configId;
      notifyListeners();

      final config = _configs.firstWhere((c) => c.id == configId);
      await _vpnService.startVpn(config.rawConfig);
      await ConfigService.saveActiveConfig(configId);
      
      _status = VpnStatus.connected;
      debugPrint('✅ اتصال به ${config.name}');
      
    } catch (e) {
      _status = VpnStatus.error;
      _errorMessage = 'خطا: $e';
      debugPrint('❌ $e');
    }
    notifyListeners();
  }

  /// قطع
  Future<void> disconnect() async {
    try {
      _errorMessage = null;
      await _vpnService.stopVpn();
      await ConfigService.saveActiveConfig(null);
      _status = VpnStatus.disconnected;
      _selectedConfigId = null;
    } catch (e) {
      _status = VpnStatus.error;
      _errorMessage = 'خطا: $e';
    }
    notifyListeners();
  }

  /// بارگذاری
  Future<void> loadConfigs() async {
    try {
      _errorMessage = null;
      _configs = await ConfigService.loadConfigs();
      _selectedConfigId = await ConfigService.loadActiveConfig();
      debugPrint('✅ ${_configs.length} کانفیگ بارگذاری شد');
      notifyListeners();
    } catch (e) {
      _errorMessage = 'خطا: $e';
      notifyListeners();
    }
  }

  /// اضافه کردن
  Future<void> addConfig(VpnConfig config) async {
    try {
      _errorMessage = null;
      _configs.add(config);
      await ConfigService.saveConfigs(_configs);
      notifyListeners();
      debugPrint('✅ ${config.name} اضافه شد');
    } catch (e) {
      _errorMessage = 'خطا: $e';
      notifyListeners();
    }
  }

  /// حذف
  Future<void> deleteConfig(String configId) async {
    try {
      _errorMessage = null;
      _configs.removeWhere((c) => c.id == configId);
      
      if (_selectedConfigId == configId) {
        await disconnect();
      }
      
      await ConfigService.saveConfigs(_configs);
      notifyListeners();
      debugPrint('✅ حذف شد');
    } catch (e) {
      _errorMessage = 'خطا: $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _supervisor.dispose();
    super.dispose();
  }
}