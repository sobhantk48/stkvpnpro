import 'protocol_ranker.dart';
import 'protocol_score.dart';

class AutoSelector {

  static String select(

    List<ProtocolScore>
        protocols,

  ) {

    final ranked =

        ProtocolRanker
            .rank(
                protocols);

    return ranked
        .first
        .protocol;
  }
}
