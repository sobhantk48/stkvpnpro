import 'package:flutter/material.dart';

class VpnConnectCard
    extends StatelessWidget {

  final String status;

  final VoidCallback
      onConnect;

  final VoidCallback
      onDisconnect;

  const VpnConnectCard({

    super.key,

    required this.status,

    required this.onConnect,

    required this.onDisconnect,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Card(

      child: Padding(

        padding:
            const EdgeInsets
                .all(20),

        child: Column(

          children: [

            Text(status),

            const SizedBox(
              height: 16,
            ),

            ElevatedButton(

              onPressed:
                  onConnect,

              child:
                  const Text(
                      "Connect"),
            ),

            ElevatedButton(

              onPressed:
                  onDisconnect,

              child:
                  const Text(
                      "Disconnect"),
            ),
          ],
        ),
      ),
    );
  }
}
