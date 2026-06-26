import 'libbox_bridge.dart';

class RuntimeVerify {

  static Future<void>
      verify() async {

    final ok =
        await LibboxBridge
            .initialize();

    final version =
        await LibboxBridge
            .version();

    print(
      "LIBBOX_INIT=$ok",
    );

    print(
      "LIBBOX_VERSION=$version",
    );
  }
}
