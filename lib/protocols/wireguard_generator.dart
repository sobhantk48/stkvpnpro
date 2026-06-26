import 'dart:convert';

import 'wireguard_profile.dart';

class WireGuardGenerator {

  static String generate(
    WireGuardProfile p,
  ) {

    return jsonEncode({

      "type":"wireguard",

      "server":
          p.server,

      "server_port":
          p.port,

      "private_key":
          p.privateKey,

      "peer_public_key":
          p.publicKey,
    });
  }
}
