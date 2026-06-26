import 'bulk_parser.dart';
import 'import_result.dart';

class ImportEngine {

  static ImportResult
      import(
    List<String> configs,
  ) {

    final parsed =

        BulkParser
            .parse(
                configs);

    return ImportResult(

      total:
          configs.length,

      success:
          parsed.length,

      failed:
          configs.length -
              parsed.length,
    );
  }
}
