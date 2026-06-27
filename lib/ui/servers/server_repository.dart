import 'server_item.dart';

class ServerRepository {

  static List<ServerItem>
      demo() {

    return const [

      ServerItem(

        name:
            "Germany",

        protocol:
            "VLESS",

        ping:
            32,
      ),

      ServerItem(

        name:
            "Singapore",

        protocol:
            "TUIC",

        ping:
            75,
      ),

      ServerItem(

        name:
            "WARP",

        protocol:
            "WIREGUARD",

        ping:
            18,

        favorite:
            true,
      ),
    ];
  }
}
