import 'dart:convert';

import 'warp_profile.dart';

class WarpGenerator {

  static String generate(
    WarpProfile p,
  ) {

    return jsonEncode({

      "type":"wireguard",

      "private_key":
          p.privateKey,

      "peer_public_key":
          p.peerKey,

      "server":
          p.endpoint,
    });
  }
}
