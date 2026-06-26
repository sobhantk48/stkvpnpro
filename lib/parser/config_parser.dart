import 'config_model.dart';
import 'shadowsocks_parser.dart';
import 'trojan_parser.dart';
import 'vless_parser.dart';

class ConfigParser {

  static ConfigModel?
      parse(
    String config,
  ) {

    return

        VlessParser
            .parse(config)

        ??

        TrojanParser
            .parse(config)

        ??

        ShadowsocksParser
            .parse(config);
  }
}
