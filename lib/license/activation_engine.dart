import 'license_session.dart';
import 'license_state.dart';

class ActivationEngine {

  static Future<bool>
      activate(

    String deviceId,

    String token,

  ) async {

    if (token
        .isEmpty) {

      LicenseSession
          .state =

          LicenseState
              .inactive;

      return false;
    }

    LicenseSession
        .state =

        LicenseState
            .active;

    return true;
  }
}
