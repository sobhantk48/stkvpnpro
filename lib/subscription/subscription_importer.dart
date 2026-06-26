import '../parser/import_engine.dart';
import '../parser/import_result.dart';

class SubscriptionImporter {

  static ImportResult
      import(
    List<String> configs,
  ) {

    return ImportEngine
        .import(
            configs);
  }
}
