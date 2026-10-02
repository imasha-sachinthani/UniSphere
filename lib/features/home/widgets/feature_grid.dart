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
    return GridView.count(

      shrinkWrap: true,

      physics:
      const NeverScrollableScrollPhysics(),

      crossAxisCount: 2,

      crossAxisSpacing: 18,

      mainAxisSpacing: 18,

      childAspectRatio: 0.85 , padding: const EdgeInsets.all(10),

      children: [

      _FeatureCard(

      title: "Timetable",

      subtitle: "Today's classes",

      icon:
      Icons.calendar_month_rounded,

      color: Colors.blue,

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) =>
            const TimetableScreen(),

          ),

        );

      },

    ),

    _FeatureCard(

    title: "Assignments",

    subtitle: "Manage tasks",

    icon:
    Icons.assignment_rounded,

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

    _FeatureCard(

    title: "Marketplace",

    subtitle: "Buy & Sell",

    icon:
    Icons.storefront_rounded,

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

    _FeatureCard(

    title: "Lost & Found",

    subtitle: "Missing items",

    icon:
    Icons.search_rounded,

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

    ),        _FeatureCard(

          title: "Notices",

          subtitle: "Latest updates",

          icon:
          Icons.campaign_rounded,

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

        _FeatureCard(

          title: "Profile",

          subtitle: "Student account",

          icon:
          Icons.person_rounded,

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

    );

  }

}

class _FeatureCard extends StatelessWidget {

  final String title;

  final String subtitle;

  final IconData icon;

  final Color color;

  final VoidCallback onTap;

  const _FeatureCard({

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

            borderRadius:
            BorderRadius.circular(24),

            onTap: onTap,

            splashColor:
            color.withValues(alpha: 0.10),

            highlightColor:
            Colors.transparent,

            child: Ink(

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(24),

                  border: Border.all(

                    color: Colors.grey.shade200,

                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                      Colors.black.withValues(
                        alpha: 0.05,
                      ),

                      blurRadius: 14,

                      offset:
                      const Offset(0, 6),

                    ),

                  ],

                ),

                child: Padding(

                    padding:
                    const EdgeInsets.all(18),

                    child: Column(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        mainAxisAlignment:
                        MainAxisAlignment.start,

                        children: [                Container(

                          width: 52,

                          height: 52,

                          decoration: BoxDecoration(

                            color: color.withValues(
                              alpha: 0.12,
                            ),

                            borderRadius:
                            BorderRadius.circular(16),

                          ),

                          child: Icon(

                            icon,

                            color: color,

                            size: 28,

                          ),

                        ),

                          const SizedBox(height: 8),

                          Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(

                                title,

                                style: const TextStyle(

                                  fontSize: 17,

                                  fontWeight:
                                  FontWeight.bold,

                                ),

                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(

                                subtitle,

                                style: TextStyle(

                                  fontSize: 13,

                                  color:
                                  Colors.grey.shade600,

                                ),

                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Row(

                                children: [

                                  Text(

                                    "Open",

                                    style: TextStyle(

                                      color: color,

                                      fontWeight:
                                      FontWeight.bold,

                                    ),

                                  ),

                                  const SizedBox(
                                    width: 4,
                                  ),

                                  Icon(

                                    Icons.arrow_forward_ios_rounded,

                                    size: 14,

                                    color: color,

                                  ),

                                ],

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