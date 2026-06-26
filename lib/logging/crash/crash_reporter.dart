class CrashReporter {

  static final List<String>
      crashes = [];

  static void report(
    String error,
  ) {

    crashes.add(error);
  }
}
