import 'package:flutter/material.dart';

import '../../assignments/screens/assignment_screen.dart';
import '../../lost_found/screens/lost_found_screen.dart';
import '../../marketplace/screens/marketplace_screen.dart';
import '../../notices/screens/notices_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../timetable/screens/timetable_screen.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.45,
          ),
          children: [
            _QuickActionCard(
              title: "Timetable",
              subtitle: "Today's classes",
              icon: Icons.calendar_month_rounded,
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

            _QuickActionCard(
              title: "Assignments",
              subtitle: "Due tasks",
              icon: Icons.assignment_rounded,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const AssignmentScreen(),
                  ),
                );
              },
            ),

            _QuickActionCard(
              title: "Notices",
              subtitle: "University updates",
              icon: Icons.campaign_rounded,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const NoticesScreen(),
                  ),
                );
              },
            ),

            _QuickActionCard(
              title: "Marketplace",
              subtitle: "Buy & Sell",
              icon: Icons.storefront_rounded,
              color: Colors.deepPurple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const MarketplaceScreen(),
                  ),
                );
              },
            ),

            _QuickActionCard(
              title: "Lost & Found",
              subtitle: "Missing items",
              icon: Icons.search_rounded,
              color: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const LostFoundScreen(),
                  ),
                );
              },
            ),

            _QuickActionCard(
              title: "Profile",
              subtitle: "Student profile",
              icon: Icons.person_rounded,
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const ProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,

        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(22),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.04,
                ),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withValues(
                      alpha: 0.12,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 26,
                  ),
                ),

                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: TextStyle(
                        color:
                        Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}