import 'package:flutter/material.dart';

import 'server_item.dart';

class ServerCard
    extends StatelessWidget {

  final ServerItem server;

  const ServerCard({

    super.key,

    required this.server,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Card(

      child: ListTile(

        title:
            Text(
                server.name),

        subtitle:
            Text(

          "${server.protocol}"
          " • "
          "${server.ping} ms",
        ),

        trailing:

            server.favorite

            ? const Icon(
                Icons.star,
              )

            : const Icon(
                Icons.star_border,
              ),
      ),
    );
  }
}
