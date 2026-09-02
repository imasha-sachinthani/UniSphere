import 'package:flutter/material.dart';

import 'dashboard_card.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 18,
      mainAxisSpacing: 18,
      childAspectRatio: 1.15,

      children: [

        DashboardCard(
          icon: Icons.calendar_month,
          title: "Timetable",
          color: Colors.blue,
          onTap: () {},
        ),

        DashboardCard(
          icon: Icons.assignment,
          title: "Assignments",
          color: Colors.green,
          onTap: () {},
        ),

        DashboardCard(
          icon: Icons.campaign,
          title: "Notices",
          color: Colors.orange,
          onTap: () {},
        ),

        DashboardCard(
          icon: Icons.shopping_bag,
          title: "Marketplace",
          color: Colors.purple,
          onTap: () {},
        ),

        DashboardCard(
          icon: Icons.search,
          title: "Lost & Found",
          color: Colors.red,
          onTap: () {},
        ),

        DashboardCard(
          icon: Icons.person,
          title: "Profile",
          color: Colors.teal,
          onTap: () {},
        ),
      ],
    );
  }
}