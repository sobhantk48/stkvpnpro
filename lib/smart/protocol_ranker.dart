import 'protocol_score.dart';

class ProtocolRanker {

  static List<ProtocolScore>
      rank(
    List<ProtocolScore>
        protocols,
  ) {

    protocols.sort(

      (a,b) =>

          b.total
              .compareTo(
                  a.total),
    );

    return protocols;
  }
}
