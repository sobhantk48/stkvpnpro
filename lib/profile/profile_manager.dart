import 'connection_profile.dart';

class ProfileManager {

  static final List<ConnectionProfile>
      profiles = [];

  static void add(
    ConnectionProfile profile,
  ) {
    profiles.add(profile);
  }
}
