class ProviderModel {

  final String name;

  final String type;

  final bool enabled;

  const ProviderModel({

    required this.name,

    required this.type,

    this.enabled = true,
  });
}
