class TaskScheduler {

  static final List<String>
      tasks = [];

  static void add(
    String task,
  ) {
    tasks.add(task);
  }

  static int count() {
    return tasks.length;
  }
}
