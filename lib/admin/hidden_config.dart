import 'admin_session.dart';

class HiddenConfig {

  static bool
      canView() {

    return
        AdminSession
            .isAdmin;
  }
}
