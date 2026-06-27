import 'ping_model.dart';

class ServerRanker {

  static List<PingModel>
      rank(
    List<PingModel> servers,
  ) {

    servers.sort(

      (a,b) =>

          b.score
              .compareTo(
                  a.score),
    );

    return servers;
  }
}
