import 'package:flutter/foundation.dart';

class TrafficController {

  static ValueNotifier<int>
      upload =
      ValueNotifier(0);

  static ValueNotifier<int>
      download =
      ValueNotifier(0);

  static void updateUpload(
      int value,
  ) {

    upload.value = value;
  }

  static void updateDownload(
      int value,
  ) {

    download.value = value;
  }

  static void reset() {

    upload.value = 0;

    download.value = 0;
  }
}
