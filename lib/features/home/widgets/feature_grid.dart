import 'package:flutter/material.dart';

import '../../assignments/screens/assignment_screen.dart';
import '../../lost_found/screens/lost_found_screen.dart';
import '../../marketplace/screens/marketplace_screen.dart';
import '../../notices/screens/notices_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../timetable/screens/timetable_screen.dart';

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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TimetableScreen(),
              ),
            );
          },
        ),

        DashboardCard(
          icon: Icons.assignment,
          title: "Assignments",
          color: Colors.green,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AssignmentScreen(),
              ),
            );
          },
        ),

        DashboardCard(
          icon: Icons.campaign,
          title: "Notices",
          color: Colors.orange,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NoticeScreen(),
              ),
            );
          },
        ),

        DashboardCard(
          icon: Icons.shopping_bag,
          title: "Marketplace",
          color: Colors.purple,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MarketplaceScreen(),
              ),
            );
          },
        ),

        DashboardCard(
          icon: Icons.search,
          title: "Lost & Found",
          color: Colors.red,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LostFoundScreen(),
              ),
            );
          },
        ),

        DashboardCard(
          icon: Icons.person,
          title: "Profile",
          color: Colors.teal,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}