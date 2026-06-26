class SubscriptionParser {

  static List<String> parse(
    String raw,
  ) {

    return raw
        .split('\n')
        .where(
          (e) => e.trim().isNotEmpty,
        )
        .toList();
  }
}
