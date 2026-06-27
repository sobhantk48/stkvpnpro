import 'package:flutter/material.dart';

import 'admin_stat_card.dart';

class AdminDashboardScreen
    extends StatelessWidget {

  const AdminDashboardScreen({
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
                "Admin Panel"),
      ),

      body: GridView.count(

        crossAxisCount: 2,

        children: const [

          AdminStatCard(

            title:
                "Devices",

            value:
                "0",
          ),

          AdminStatCard(

            title:
                "Configs",

            value:
                "0",
          ),

          AdminStatCard(

            title:
                "Subs",

            value:
                "0",
          ),

          AdminStatCard(

            title:
                "Status",

            value:
                "OK",
          ),
        ],
      ),
    );
  }
}
