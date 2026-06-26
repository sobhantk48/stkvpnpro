class RuntimeProfile {

  final String protocol;

  final String server;

  final int port;

  final bool tls;

  final bool reality;

  const RuntimeProfile({
    required this.protocol,
    required this.server,
    required this.port,
    this.tls = true,
    this.reality = false,
  });
}
