import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../assignments/screens/assignment_screen.dart';
import '../../notices/screens/notices_screen.dart';
import '../../timetable/screens/timetable_screen.dart';

import '../controllers/dashboard_controller.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

      const Text(
      "Today's Dashboard",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(height: 18),

    /// =====================================
    /// NEXT CLASS
    /// =====================================

    StreamBuilder<QueryDocumentSnapshot?>(
    stream:
    DashboardController.nextClass(),

    builder: (context, snapshot) {

    if (!snapshot.hasData) {

    return _emptyCard(

    icon:
    Icons.calendar_month,

    title:
    "No Classes Today",

    subtitle:
    "Enjoy your day.",

    );

    }

    final data =
    snapshot.data!.data()
    as Map<String, dynamic>;

    return _dashboardCard(

    context: context,

    icon:
    Icons.calendar_month,

    color:
    Colors.blue,

    title:
    "Next Class",

    heading:
    data["subject"] ?? "",

    subtitle:
    "${data["startTime"]} - ${data["endTime"]}",

    trailing:
    data["room"] ?? "",

    onTap: () {

    Navigator.push(

    context,

    MaterialPageRoute(

    builder: (_) =>
    const TimetableScreen(),

    ),

    );

    },

    );

    },

    ),

    const SizedBox(height: 16),

    /// =====================================
    /// UPCOMING ASSIGNMENT
    /// =====================================

    StreamBuilder<QueryDocumentSnapshot?>(
    stream:
    DashboardController
        .upcomingAssignment(),

    builder: (context, snapshot) {

    if (!snapshot.hasData) {

    return _emptyCard(

    icon:
    Icons.assignment,

    title:
    "No Upcoming Assignments",

    subtitle:
    "You're all caught up.",

    );

    }

    final data =
    snapshot.data!.data()
    as Map<String, dynamic>;

    return Padding(

    padding:
    const EdgeInsets.only(
    bottom: 16,
    ),

    child: _dashboardCard(

    context: context,

    icon:
    Icons.assignment,

    color:
    Colors.green,

    title:
    "Due Assignment",

    heading:
    data["title"] ?? "",

    subtitle:
    data["module"] ?? "",

    trailing:
    data["priority"] == 3
    ? "High"
        : data["priority"] == 2
    ? "Medium"
        : "Low",

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

    );

    },

    ),
        /// =====================================
        /// LATEST NOTICE
        /// =====================================

        StreamBuilder<QueryDocumentSnapshot?>(
          stream:
          DashboardController
              .latestNotice(),

          builder: (context, snapshot) {

            if (!snapshot.hasData) {

              return _emptyCard(

                icon:
                Icons.campaign,

                title:
                "No Notices",

                subtitle:
                "No announcements available.",

              );

            }

            final data =
            snapshot.data!.data()
            as Map<String, dynamic>;

            return _dashboardCard(

              context: context,

              icon:
              Icons.campaign,

              color:
              Colors.orange,

              title:
              "Latest Notice",

              heading:
              data["title"] ?? "",

              subtitle:
              data["department"] ?? "",

              trailing:
              data["priority"] ?? "",

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                    const NoticesScreen(),

                  ),

                );

              },

            );

          },

        ),

      ],
    );

  }

  /// =====================================
  /// DASHBOARD CARD
  /// =====================================

  Widget _dashboardCard({

    required BuildContext context,

    required IconData icon,

    required Color color,

    required String title,

    required String heading,

    required String subtitle,

    required String trailing,

    required VoidCallback onTap,

  }) {

    return Padding(

        padding: const EdgeInsets.only(
          bottom: 16,
        ),

        child: InkWell(

            borderRadius:
            BorderRadius.circular(20),

            onTap: onTap,

            child: Container(

                padding:
                const EdgeInsets.all(18),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(20),

                  boxShadow: [

                    BoxShadow(

                      color:
                      Colors.black.withValues(
                        alpha: 0.05,
                      ),

                      blurRadius: 14,

                      offset:
                      const Offset(0, 5),

                    ),

                  ],

                ),

                child: Row(

                  children: [

                  CircleAvatar(

                  radius: 26,

                  backgroundColor:
                  color.withValues(
                    alpha: 0.15,
                  ),

                  child: Icon(

                    icon,

                    color: color,

                    size: 28,

                  ),

                ),

                const SizedBox(width: 16),

                Expanded(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                    Text(

                    title,

                    style:
                    const TextStyle(

                      color: Colors.grey,

                      fontSize: 13,

                      fontWeight:
                      FontWeight.w500,

                    ),

                  ),

                  const SizedBox(height: 6),

                  Text(

                    heading,

                    maxLines: 1,

                    overflow:
                    TextOverflow.ellipsis,

                    style:
                    const TextStyle(

                      fontSize: 18,

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 6),

                  Text(

                    subtitle,

                    maxLines: 1,

                    overflow:
                    TextOverflow.ellipsis,

                    style:
                    const TextStyle(

                      color: Colors.grey,

                    ),

                  ),
                    ],
                  ),
                ),

                    const SizedBox(width: 12),

                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [

                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(
                              alpha: 0.12,
                            ),
                            borderRadius:
                            BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: Text(
                            trailing,
                            style: TextStyle(
                              color: color,
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
            ),
        ),
    );
  }

  /// =====================================
  /// EMPTY CARD
  /// =====================================

  Widget _emptyCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius:
          BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [

            CircleAvatar(
              radius: 24,
              backgroundColor:
              Colors.grey.shade200,
              child: Icon(
                icon,
                color: Colors.grey,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
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

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}