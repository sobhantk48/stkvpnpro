import 'config_source.dart';

class SourceManager {

  static final List<ConfigSource>
      _sources = [];

  static List<ConfigSource>
      get all =>
          List.unmodifiable(
            _sources,
          );

  static void add(
    ConfigSource source,
  ) {
    _sources.add(source);
  }

  static void clear() {
    _sources.clear();
  }
}
