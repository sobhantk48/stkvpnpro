import 'traffic_bridge.dart';

class TrafficSimulator {

  static void tick() {

    TrafficBridge.pushUpload(5);

    TrafficBridge.pushDownload(12);
  }
}
