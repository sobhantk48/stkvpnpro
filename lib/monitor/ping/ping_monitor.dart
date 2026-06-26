import 'ping_result.dart';

class PingMonitor {

  static Future<PingResult>
      ping(
    String host,
  ) async {

    return const PingResult(
      milliseconds: 0,
      success: false,
    );
  }
}
