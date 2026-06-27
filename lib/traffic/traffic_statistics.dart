import 'traffic_counter.dart';
import 'traffic_model.dart';

class TrafficStatistics {

  static TrafficModel
      current() {

    return TrafficModel(

      upload:
          TrafficCounter.upload,

      download:
          TrafficCounter.download,

      total:
          TrafficCounter.upload +
              TrafficCounter.download,
    );
  }
}
