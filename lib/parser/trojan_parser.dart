import 'config_model.dart';

class TrojanParser {

  static ConfigModel?
      parse(
    String link,
  ) {

    if (!link.startsWith(
        "trojan://")) {

      return null;
    }

    return ConfigModel(

      protocol:
          "trojan",

      raw:
          link,
    );
  }
}
