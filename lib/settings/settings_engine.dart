class SettingsEngine {

  static final Map<String,dynamic>
      settings = {};

  static void set(
    String key,
    dynamic value,
  ) {
    settings[key] = value;
  }

  static dynamic get(
    String key,
  ) {
    return settings[key];
  }
}
