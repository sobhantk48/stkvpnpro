class SplitTunnel {

  static final List<String>
      applications = [];

  static void add(
    String packageName,
  ) {

    if (!applications
        .contains(
            packageName)) {

      applications
          .add(
              packageName);
    }
  }

  static void remove(
    String packageName,
  ) {

    applications
        .remove(
            packageName);
  }
}
