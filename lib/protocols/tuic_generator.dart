import 'dart:convert';

import 'tuic_profile.dart';

class TuicGenerator {

  static String generate(
    TuicProfile p,
  ) {

    return jsonEncode({

      "type":"tuic",

      "server":
          p.server,

      "server_port":
          p.port,

      "uuid":
          p.uuid,

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
