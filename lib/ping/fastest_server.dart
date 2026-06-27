import 'ping_model.dart';
import 'server_ranker.dart';

class FastestServer {

  static PingModel?
      select(
    List<PingModel> servers,
  ) {

    if (servers.isEmpty) {

      return null;
    }

    return ServerRanker
        .rank(
            servers)
        .first;
  }
}
