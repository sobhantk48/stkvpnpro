import 'sni_selector.dart';

class TlsCamouflage {

  static Map<String,
      dynamic>
      build() {

    return {

      "enabled":
          true,

      "server_name":

          SniSelector
              .select(),
    };
  }
}
