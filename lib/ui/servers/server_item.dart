class ServerItem {

  final String name;

  final String protocol;

  final int ping;

  final bool favorite;

  const ServerItem({

    required this.name,

    required this.protocol,

    required this.ping,

    this.favorite = false,
  });
}
