import 'vless_generator.dart';
import 'vless_profile.dart';

class VlessRuntimeTest {

  static String test() {

    return VlessGenerator
        .generate(

      const VlessProfile(

        server:
            "example.com",

        port:
            443,

        uuid:
            "00000000-0000-0000-0000-000000000000",

        publicKey:
            "PUBLIC_KEY",

        shortId:
            "abcd",

        sni:
            "google.com",
      ),
    );
  }
}
