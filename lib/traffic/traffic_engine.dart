import 'traffic_model.dart';

class TrafficEngine {

  static final TrafficModel
      _traffic =
      TrafficModel();

  static void addUpload(
    int value,
  ) {

    _traffic.upload += value;
  }

  static void addDownload(
    int value,
  ) {

    _traffic.download += value;
  }

  static int upload() {

    return _traffic.upload;
  }

  static int download() {

    return _traffic.download;
  }

  static void reset() {

    _traffic.upload = 0;

    _traffic.download = 0;
  }
}
