class PingModel {

  final String server;

  final int latency;

  final int stability;

  const PingModel({

    required this.server,

    required this.latency,

    required this.stability,
  });

  int get score {

    return
        stability -
        latency;
  }
}
