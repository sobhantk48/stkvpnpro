class AdminManager {

  static String? _password;

  static bool get initialized =>
      _password != null;

  static void setup(
    String password,
  ) {
    _password = password;
  }

  static bool login(
    String password,
  ) {
    return _password == password;
  }
}
