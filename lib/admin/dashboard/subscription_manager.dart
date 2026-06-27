class AdminSubscriptionManager {

  static final List<String>
      subscriptions = [];

  static void add(
    String url,
  ) {

    subscriptions.add(url);
  }

  static int count() {

    return subscriptions.length;
  }
}
