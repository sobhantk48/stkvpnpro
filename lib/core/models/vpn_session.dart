class VpnSession {
  final String profileName;
  final String engine;
  final DateTime startedAt;
  final bool connected;

  const VpnSession({
    required this.profileName,
    required this.engine,
    required this.startedAt,
    required this.connected,
  });
}
