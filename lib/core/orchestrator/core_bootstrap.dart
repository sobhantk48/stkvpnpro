import 'application_controller.dart';

class CoreBootstrap {

  static Future<void>
      boot() async {

    await ApplicationController
        .initialize();
  }
}
