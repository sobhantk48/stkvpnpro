import 'config_parser.dart';
import 'config_model.dart';

class BulkParser {

  static List<ConfigModel>
      parse(
    List<String> configs,
  ) {

    final result =
        <ConfigModel>[];

    for (final config
        in configs) {

      final parsed =

          ConfigParser
              .parse(
                  config);

      if (parsed !=
          null) {

        result.add(
            parsed);
      }
    }

    return result;
  }
}
