import 'connection_pool.dart';

class MuxEngine {

  static bool enabled =
      true;

  static bool get active {

    return enabled &&
        ConnectionPool
            .count > 0;
  }
}
