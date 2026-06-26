class AdminSecurity {

  static String? _password;

  static void setup(
    String password,
  ) {
    _password = password;
  }

  static bool verify(
    String password,
  ) {

    return _password ==
        password;
  }
}
