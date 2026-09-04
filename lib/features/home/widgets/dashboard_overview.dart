import 'package:flutter/material.dart';

import '../controllers/dashboard_controller.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  Widget buildTile(
      String title,
      IconData icon,
      Color color,
      Stream<int> stream,
      ) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            title: Text(title),
            trailing: Text(
              "$count",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        const Text(
          "Today's Overview",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        buildTile(
          "Assignments",
          Icons.assignment,
          Colors.green,
          DashboardController.assignments(),
        ),

        buildTile(
          "Timetable",
          Icons.calendar_month,
          Colors.blue,
          DashboardController.timetable(),
        ),

        buildTile(
          "Notices",
          Icons.campaign,
          Colors.orange,
          DashboardController.notices(),
        ),

        buildTile(
          "Marketplace",
          Icons.shopping_bag,
          Colors.purple,
          DashboardController.marketplace(),
        ),

        buildTile(
          "Lost & Found",
          Icons.search,
          Colors.red,
          DashboardController.lostFound(),
        ),
      ],
    );
  }
}