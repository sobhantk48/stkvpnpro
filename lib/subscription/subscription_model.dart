class SubscriptionModel {

  final String name;

  final String url;

  final bool enabled;

  const SubscriptionModel({

    required this.name,

    required this.url,

    this.enabled = true,
  });
}
