import 'activation_status.dart';

class DeviceManager {

  static ActivationStatus status =
      ActivationStatus.inactive;

  static String? token;

  static Future<void>
      activate(
    String value,
  ) async {

    token = value;

    status =
        ActivationStatus.active;
  }

  static void deactivate() {

    token = null;

    status =
        ActivationStatus.inactive;
  }
}
