import 'provider_model.dart';

class ProviderManager {

  static final List<ProviderModel>
      providers = [];

  static void add(
    ProviderModel provider,
  ) {

    providers.add(provider);
  }

  static int count() {

    return providers.length;
  }
}
