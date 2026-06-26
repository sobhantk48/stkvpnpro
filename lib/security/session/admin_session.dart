class AdminSession {

  static bool loggedIn =
      false;

  static void login() {
    loggedIn = true;
  }

  static void logout() {
    loggedIn = false;
  }
}
