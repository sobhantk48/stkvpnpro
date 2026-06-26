class AppModel {

  final String packageName;

  final String appName;

  final bool enabled;

  const AppModel({

    required this.packageName,

    required this.appName,

    this.enabled = true,
  });
}
