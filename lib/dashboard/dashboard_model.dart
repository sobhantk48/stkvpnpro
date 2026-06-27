import 'connection_state.dart';

class DashboardModel {

  final ConnectionState state;

  final String protocol;

  final int ping;

  final int upload;

  final int download;

  const DashboardModel({

    required this.state,

    required this.protocol,

    required this.ping,

    required this.upload,

    required this.download,
  });
}
