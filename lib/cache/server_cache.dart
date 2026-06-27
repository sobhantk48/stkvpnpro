class ServerCache {

  static final Map<String,
      dynamic> cache = {};

  static void put(

    String key,

    dynamic value,

  ) {

    cache[key] = value;
  }

  static dynamic get(
    String key,
  ) {

    return cache[key];
  }
}
