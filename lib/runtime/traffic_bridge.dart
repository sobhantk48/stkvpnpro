import '../ui/traffic/traffic_controller.dart';

class TrafficBridge {

  static void pushUpload(int v) {

    TrafficController
        .updateUpload(v);
  }

  static void pushDownload(int v) {

    TrafficController
        .updateDownload(v);
  }
}
