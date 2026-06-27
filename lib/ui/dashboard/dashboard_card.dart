import 'package:flutter/material.dart';

class DashboardCard
    extends StatelessWidget {

  final String title;

  final String value;

  const DashboardCard({

    super.key,

    required this.title,

    required this.value,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Card(

      child: Padding(

        padding:
            const EdgeInsets
                .all(16),

        child: Column(

          children: [

            Text(title),

            const SizedBox(
              height: 8,
            ),

            Text(
              value,
            ),
          ],
        ),
      ),
    );
  }
}
