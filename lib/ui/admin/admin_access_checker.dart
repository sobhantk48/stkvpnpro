import '../../admin/admin_session.dart';

class AdminAccessChecker {

  static bool allow() {

    return AdminSession
        .isAdmin;
  }
}
