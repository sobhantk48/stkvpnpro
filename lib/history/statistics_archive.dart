class StatisticsArchive {

  static final List<int>
      archive = [];

  static void save(
    int value,
  ) {

    archive.add(value);
  }
}
