class FavoriteServer {

  static final List<String>
      servers = [];

  static void add(
    String server,
  ) {
    servers.add(server);
  }

  static bool contains(
    String server,
  ) {
    return servers.contains(server);
  }
}
