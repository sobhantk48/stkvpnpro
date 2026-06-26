import 'hop_model.dart';

class RouteBuilder {

  static List<Map<String,dynamic>>
      build(
    List<HopModel> hops,
  ) {

    return hops.map(

      (e) => {

        "type":
            e.protocol,

        "server":
            e.server,

        "port":
            e.port,
      },

    ).toList();
  }
}
