import 'package:flutter/material.dart';

import 'dashboard_card.dart';

class DashboardScreen
    extends StatelessWidget {

  const DashboardScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
                "STK VPN"),
      ),

      body: GridView.count(

        crossAxisCount: 2,

        children: const [

          DashboardCard(

            title:
                "Status",

            value:
                "Connected",
          ),

          DashboardCard(

            title:
                "Protocol",

            value:
                "VLESS",
          ),

          DashboardCard(

            title:
                "Ping",

            value:
                "25 ms",
          ),

          DashboardCard(

            title:
                "Traffic",

            value:
                "0 MB",
          ),
        ],
      ),
    );
  }
}
