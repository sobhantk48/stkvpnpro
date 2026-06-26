class VlessProfile {

  final String server;

  final int port;

  final String uuid;

  final String publicKey;

  final String shortId;

  final String sni;

  final String fingerprint;

  const VlessProfile({

    required this.server,

    required this.port,

    required this.uuid,

    required this.publicKey,

    required this.shortId,

    required this.sni,

    this.fingerprint =
        "chrome",
  });
}
