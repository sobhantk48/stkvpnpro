import 'dart:convert';

import 'vless_profile.dart';

class VlessGenerator {

  static String generate(
    VlessProfile p,
  ) {

    final config = {

      "type": "vless",

      "server":
          p.server,

      "server_port":
          p.port,

      "uuid":
          p.uuid,

      "flow":
          "xtls-rprx-vision",

      "tls": {

        "enabled":
            true,

        "server_name":
            p.sni,

        "reality": {

          "enabled":
              true,

          "public_key":
              p.publicKey,

          "short_id":
              p.shortId,
        },

        "utls": {

          "enabled":
              true,

          "fingerprint":
              p.fingerprint,
        }
      }
    };

    return jsonEncode(
      config,
    );
  }
}
