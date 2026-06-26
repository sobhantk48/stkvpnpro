import 'subscription.dart';

class SubscriptionManager {

  static Subscription? current;

  static Future<void> set(
    String url,
  ) async {

    current = Subscription(
      url: url,
      updatedAt: DateTime.now(),
    );
  }

  static Future<void> refresh()
  async {
    // TODO
  }
}
