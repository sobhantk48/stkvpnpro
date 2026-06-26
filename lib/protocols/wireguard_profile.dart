class WireGuardProfile {

  final String server;

  final int port;

  final String privateKey;

  final String publicKey;

  const WireGuardProfile({

    required this.server,

    required this.port,

    required this.privateKey,

    required this.publicKey,
  });
}
