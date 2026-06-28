import 'package:flutter_test/flutter_test.dart';
import 'package:stkvpnpro/core/core_supervisor.dart';

void main() {
  group('CoreSupervisor basic behavior', () {
    test('statusNotifier initial value is Disconnected', () {
      expect(CoreSupervisor.statusNotifier.value, 'Disconnected');
    });

    test('setRunning updates statusNotifier', () {
      CoreSupervisor.setRunning(true);
      expect(CoreSupervisor.statusNotifier.value, 'Connected');
      CoreSupervisor.setRunning(false);
      expect(CoreSupervisor.statusNotifier.value, 'Disconnected');
    });

    test('updateTraffic updates trafficNotifier', () {
      CoreSupervisor.updateTraffic(10, 20, 30);
      final traffic = CoreSupervisor.trafficNotifier.value;
      expect(traffic['upload'], 10);
      expect(traffic['download'], 20);
      expect(traffic['ping'], 30);
    });
  });
}