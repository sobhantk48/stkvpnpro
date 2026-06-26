class RuntimeConfig {

  final String config;

  final bool enableTun;

  final bool enableMux;

  final bool enableIPv6;

  const RuntimeConfig({

    required this.config,

    this.enableTun = true,

    this.enableMux = true,

    this.enableIPv6 = true,
  });
}
