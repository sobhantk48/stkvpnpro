/// تست‌های یکپارچگی برای اپلیکیشن VPN
/// 
/// این فایل تست‌های اصلی را برای بررسی کارکرد صحیح
/// تمام ماژول‌های اپلیکیشن شامل می‌شود.

import 'package:flutter_test/flutter_test.dart';
import 'package:stkvpnpro/services/native_service.dart';
import 'package:stkvpnpro/core/core_supervisor.dart';

void main() {
  group('STK VPN Pro Integration Tests', () {
    
    test('CoreSupervisor initialization', () async {
      final supervisor = CoreSupervisor();
      expect(supervisor.isInitialized, false);
      
      // Initialize
      await supervisor.initialize();
      expect(supervisor.isInitialized, true);
    });

    test('NativeService ping', () async {
      final result = await NativeService.ping();
      expect(result, isA<bool>());
    });

    test('CoreSupervisor settings management', () async {
      final supervisor = CoreSupervisor();
      await supervisor.initialize();
      
      // Save setting
      await supervisor.saveSetting('testKey', 'testValue');
      
      // Get setting
      final value = supervisor.getSetting('testKey');
      expect(value, 'testValue');
    });

    test('NativeService get profiles', () async {
      final profiles = await NativeService.getProfiles();
      expect(profiles, isA<List<String>>());
    });

    test('NativeService status check', () async {
      final status = await NativeService.getStatus();
      expect(status, isA<String?>());
    });
  });
}
