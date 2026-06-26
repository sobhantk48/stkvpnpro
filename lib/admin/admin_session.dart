class AdminSession {

  static bool
      authenticated =
      false;

  static void login() {

    authenticated =
        true;
  }

  static void logout() {

    authenticated =
        false;
  }

  static bool
      get isAdmin {

    return
        authenticated;
  }
}
