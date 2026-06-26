import 'dart:convert';

import 'shadowsocks_profile.dart';

class ShadowsocksGenerator {

  static String generate(
    ShadowsocksProfile p,
  ) {

    return jsonEncode({

      "type":"shadowsocks",

      "server":
          p.server,

      "server_port":
          p.port,

      "method":
          p.method,

      "password":
          p.password,
    });
  }
}
