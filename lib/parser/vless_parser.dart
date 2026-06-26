import 'config_model.dart';

class VlessParser {

  static ConfigModel?
      parse(
    String link,
  ) {

    if (!link.startsWith(
        "vless://")) {

      return null;
    }

    return ConfigModel(

      protocol:
          "vless",

      raw:
          link,
    );
  }
}
