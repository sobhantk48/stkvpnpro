import 'traffic_engine.dart';

class TrafficTest {

  static bool run() {

    TrafficEngine
        .addUpload(10);

    TrafficEngine
        .addDownload(20);

    return

        TrafficEngine.upload() == 10 &&
        TrafficEngine.download() == 20;
  }
}
