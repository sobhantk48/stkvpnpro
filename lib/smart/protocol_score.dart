class ProtocolScore {

  final String protocol;

  final int ping;

  final int stability;

  final int speed;

  final int location;

  const ProtocolScore({

    required this.protocol,

    required this.ping,

    required this.stability,

    required this.speed,

    required this.location,
  });

  int get total {

    return
        speed +
        stability +
        location -
        ping;
  }
}
