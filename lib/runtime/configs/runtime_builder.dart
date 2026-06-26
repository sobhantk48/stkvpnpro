import 'dart:convert';

import 'runtime_profile.dart';

class RuntimeBuilder {

  static String build(
    RuntimeProfile profile,
  ) {

    final config = {

      "log": {
        "level": "info",
      },

      "inbounds": [],

      "outbounds": [
        {
          "type": profile.protocol,
          "server": profile.server,
          "server_port": profile.port,
        }
      ],
    };

    return jsonEncode(
      config,
    );
  }
}
