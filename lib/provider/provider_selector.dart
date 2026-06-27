import 'provider_manager.dart';
import 'provider_model.dart';

class ProviderSelector {

  static ProviderModel?
      select() {

    if (ProviderManager
        .providers
        .isEmpty) {

      return null;
    }

    return ProviderManager
        .providers
        .first;
  }
}
