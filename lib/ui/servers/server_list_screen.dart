import 'package:flutter/material.dart';

import 'server_card.dart';
import 'server_repository.dart';

class ServerListScreen
    extends StatelessWidget {

  const ServerListScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final servers =

        ServerRepository
            .demo();

    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
                "Servers"),
      ),

      body: ListView.builder(

        itemCount:
            servers.length,

        itemBuilder:
            (_, i) {

          return ServerCard(

            server:
                servers[i],
          );
        },
      ),
    );
  }
}
