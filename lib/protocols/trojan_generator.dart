import 'dart:convert';

import 'trojan_profile.dart';

class TrojanGenerator {

  static String generate(
    TrojanProfile p,
  ) {

    return jsonEncode({

      "type":"trojan",

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
