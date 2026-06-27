class PolicyEngine {

  static final Map<String,bool>
      policies = {};

  static void set(

    String name,

    bool value,

  ) {

    policies[name] =
        value;
  }

  static bool enabled(
    String name,
  ) {

    return policies[name]
        ?? false;
  }
}
