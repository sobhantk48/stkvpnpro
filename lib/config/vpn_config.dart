class VpnConfig {
  final String id;
  final String name;
  final String protocol;
  final String rawConfig;

  const VpnConfig({
    required this.id,
    required this.name,
    required this.protocol,
    required this.rawConfig,
  });
}
