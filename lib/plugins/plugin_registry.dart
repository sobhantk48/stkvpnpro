class PluginRegistry {

  static final List<String>
      plugins = [];

  static void register(
    String plugin,
  ) {
    plugins.add(plugin);
  }

  static int count() {
    return plugins.length;
  }
}
