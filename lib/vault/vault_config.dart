class VaultConfig {

  final String id;

  final String config;

  final bool hidden;

  const VaultConfig({

    required this.id,

    required this.config,

    this.hidden = true,
  });
}
