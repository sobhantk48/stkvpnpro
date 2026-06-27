class TrafficCounter {

  static int upload = 0;

  static int download = 0;

  static void addUpload(
    int bytes,
  ) {

    upload += bytes;
  }

  static void addDownload(
    int bytes,
  ) {

    download += bytes;
  }

  static void reset() {

    upload = 0;

    download = 0;
  }
}
