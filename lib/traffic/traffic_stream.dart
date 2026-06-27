import 'traffic_engine.dart';

class TrafficStream {

  static void simulate() {

    TrafficEngine
        .addUpload(5);

    TrafficEngine
        .addDownload(12);
  }
}
