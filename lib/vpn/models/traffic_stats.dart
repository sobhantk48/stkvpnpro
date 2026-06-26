class TrafficStats {
  final int upload;
  final int download;

  const TrafficStats({
    required this.upload,
    required this.download,
  });

  static const empty = TrafficStats(
    upload: 0,
    download: 0,
  );
}
