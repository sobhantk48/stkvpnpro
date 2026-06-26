import 'config_model.dart';

class ShadowsocksParser {

  static ConfigModel?
      parse(
    String link,
  ) {

    if (!link.startsWith(
        "ss://")) {

      return null;
    }

    return ConfigModel(

      protocol:
          "shadowsocks",

      raw:
          link,
    );
  }
}
