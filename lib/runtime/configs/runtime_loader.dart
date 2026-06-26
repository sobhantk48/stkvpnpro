import 'runtime_builder.dart';
import 'runtime_profile.dart';
import 'runtime_validator.dart';

class RuntimeLoader {

  static Future<String?>
      load(
    RuntimeProfile profile,
  ) async {

    final config =
        RuntimeBuilder
            .build(
      profile,
    );

    if (!RuntimeValidator
        .validate(
      config,
    )) {

      return null;
    }

    return config;
  }
}
