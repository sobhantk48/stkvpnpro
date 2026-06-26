import 'config_source_type.dart';

class ConfigSource {

  final String name;
  final String url;
  final ConfigSourceType type;

  const ConfigSource({
    required this.name,
    required this.url,
    required this.type,
  });
}
