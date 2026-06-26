import 'protocol_type.dart';

class ConfigParser {

  static ProtocolType detect(
    String config,
  ) {

    if (config.startsWith(
      "vless://",
    )) {
      return ProtocolType.vless;
    }

    if (config.startsWith(
      "trojan://",
    )) {
      return ProtocolType.trojan;
    }

    if (config.startsWith(
      "ss://",
    )) {
      return ProtocolType.shadowsocks;
    }

    if (config.startsWith(
      "wireguard://",
    )) {
      return ProtocolType.wireguard;
    }

    return ProtocolType.unknown;
  }
}
