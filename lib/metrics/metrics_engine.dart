class MetricsEngine {

  static final Map<String,int>
      metrics = {};

  static void add(
    String key,
    int value,
  ) {

    metrics[key] =
        (metrics[key] ?? 0)
        + value;
  }

  static int get(
    String key,
  ) {

    return metrics[key] ?? 0;
  }
}
