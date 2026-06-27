import 'server_repository.dart';

class ServerTest {

  static bool run() {

    return
        ServerRepository
            .demo()
            .isNotEmpty;
  }
}
