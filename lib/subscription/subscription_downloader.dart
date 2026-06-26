import 'dart:convert';

import 'package:http/http.dart'
    as http;

class SubscriptionDownloader {

  static Future<List<String>>
      download(
    String url,
  ) async {

    final response =
        await http.get(
      Uri.parse(url),
    );

    if (response.statusCode !=
        200) {

      return [];
    }

    return LineSplitter
        .split(
            response.body)
        .toList();
  }
}
