import 'package:flutter/material.dart';
import '../status/vpn_status_controller.dart';
import '../traffic/traffic_controller.dart';

class VpnDashboard extends StatelessWidget {

  const VpnDashboard({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("STK VPN"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            ValueListenableBuilder(

              valueListenable:
                  VpnStatusController.state,

              builder: (context, value, _) {

                return Text(
                  "Status: $value",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            ValueListenableBuilder(

              valueListenable:
                  TrafficController.upload,

              builder: (context, value, _) {

                return Text(
                  "Upload: $value KB/s",
                );
              },
            ),

            ValueListenableBuilder(

              valueListenable:
                  TrafficController.download,

              builder: (context, value, _) {

                return Text(
                  "Download: $value KB/s",
                );
              },
            ),

            const Spacer(),

            Row(

              children: [

                ElevatedButton(

                  onPressed: () {

                    // Connect action placeholder
                  },

                  child: const Text("Connect"),
                ),

                const SizedBox(width: 10),

                ElevatedButton(

                  onPressed: () {

                    // Disconnect action placeholder
                  },

                  child: const Text("Disconnect"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
