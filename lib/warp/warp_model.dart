class WarpModel {

  final String endpoint;

  final String publicKey;

  final bool enabled;

  const WarpModel({

    required this.endpoint,

    required this.publicKey,

    this.enabled = true,
  });
}
