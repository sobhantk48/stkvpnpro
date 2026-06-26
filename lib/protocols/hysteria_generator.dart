import 'dart:convert';

import 'hysteria_profile.dart';

class HysteriaGenerator {

  static String generate(
    HysteriaProfile p,
  ) {

    return jsonEncode({

      "type":"hysteria2",

      "server":
          p.server,

      "server_port":
          p.port,

      "password":
          p.password,

      "tls":{

        "enabled":true,

        "server_name":
            p.sni,
      }
    });
  }
}
