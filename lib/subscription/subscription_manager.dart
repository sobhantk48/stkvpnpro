import 'subscription_downloader.dart';

class SubscriptionManager {

  static Future<List<String>>
      update(
    String url,
  ) async {

    return await
        SubscriptionDownloader
            .download(
                url);
  }
}
