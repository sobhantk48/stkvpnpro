class FeatureFlags {

  static final Map<String,bool>
      flags = {};

  static void enable(
    String feature,
  ) {

    flags[feature] =
        true;
  }

  static bool has(
    String feature,
  ) {

    return flags[feature]
        ?? false;
  }
}
