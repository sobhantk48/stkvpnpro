import 'services/native_service.dart';

class RuntimeTest {

  static Future<void>
      test() async {

    final ping =
        await NativeService
            .ping();

    print(
      "NATIVE: $ping",
    );
  }
}
