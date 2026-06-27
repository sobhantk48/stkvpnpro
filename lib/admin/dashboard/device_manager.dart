class DeviceManager {

  static final List<String>
      devices = [];

  static void add(
    String id,
  ) {

    devices.add(id);
  }

  static int count() {

    return devices.length;
  }
}
