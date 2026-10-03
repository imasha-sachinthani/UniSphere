import 'package:flutter/material.dart';

import '../widgets/dashboard_overview.dart';
import '../widgets/feature_grid.dart';
import '../widgets/search_box.dart';
import '../widgets/welcome_header.dart';
import '../../assignments/screens/assignment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: SafeArea(
            child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(milliseconds: 800),
                  );
                },

                child: SingleChildScrollView(
                  physics:
                  const AlwaysScrollableScrollPhysics(),

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),

                  child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                      /// ============================
                      /// Welcome Header
                      /// ============================

                      const WelcomeHeader(),

                  const SizedBox(height: 26),

                  /// ============================
                  /// Search
                  /// ============================

                  const SearchBox(),

                  const SizedBox(height: 30),

                  /// ============================
                  /// Dashboard Title
                  /// ============================

                  Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Today's Dashboard",
                              style: theme
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "Everything you need today in one place.",
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 54,
                        height: 54,

                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                          BorderRadius.circular(18),

                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black.withValues(alpha: 0.35)
                                  : Colors.black.withValues(alpha: 0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.dashboard_customize_rounded,
                          color: Color(0xFF2563EB),
                          size: 28,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  /// ============================
                  /// Dashboard Cards
                  /// ============================

                  const DashboardOverview(),                const SizedBox(height: 34),

                    /// ============================
                    /// Quick Actions Header
                    /// ============================

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        Text(
                          "Quick Actions",
                          style: theme
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF2563EB,
                            ).withValues(
                              alpha: 0.08,
                            ),

                            borderRadius:
                            BorderRadius.circular(30),
                          ),

                          child: const Row(
                            children: [

                              Icon(
                                Icons.auto_awesome,
                                color: Color(0xFF2563EB),
                                size: 16,
                              ),

                              SizedBox(width: 6),

                              Text(
                                "Student Hub",
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 18),

                    /// ============================
                    /// Feature Grid
                    /// ============================

                    const FeatureGrid(),

                    const SizedBox(height: 34),

                    /// ============================
                    /// Student Tip Card
                    /// ============================

                    Container(

                        width: double.infinity,

                        padding:
                        const EdgeInsets.all(22),

                        decoration: BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(24),

                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: Theme.of(context).brightness == Brightness.dark
                                ? const [
                              Color(0xFF1E40AF),
                              Color(0xFF1D4ED8),
                            ]
                                : const [
                              Color(0xFF2563EB),
                              Color(0xFF3B82F6),
                            ],
                          ),

                          boxShadow: [

                            BoxShadow(

                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black.withValues(alpha: 0.35)
                                  : const Color(0xFF2563EB).withValues(alpha: 0.22),

                              blurRadius: 18,

                              offset:
                              const Offset(0, 8),

                            ),

                          ],

                        ),

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                        Row(

                        children: [

                        Container(

                        width: 56,

                          height: 56,

                          decoration: BoxDecoration(

                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.12)
                                : Colors.white.withValues(alpha: 0.18),

                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),

                          ),

                          child: const Icon(

                            Icons.school_rounded,

                            color: Colors.white,

                            size: 30,

                          ),

                        ),

                        const SizedBox(width: 16),

                        Expanded(                          child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(

                              "Student Tip",

                              style: TextStyle(

                                color: Colors.white,

                                fontSize: 20,

                                fontWeight:
                                FontWeight.bold,

                              ),

                            ),

                            const SizedBox(height: 4),

                          Text(
                            "Stay organized by checking your timetable, assignments and notices every day.",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.92),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),



                          ],

                        ),

                        ),

                        ],

                        ),

                            const SizedBox(height: 22),

                            SizedBox(

                              width: double.infinity,

                              child: ElevatedButton.icon(

                                onPressed: () {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder: (_) => const AssignmentScreen(),

                                    ),

                                  );

                                },

                                icon: const Icon(
                                  Icons.lightbulb_outline_rounded,
                                ),

                                label: const Text(
                                  "Explore More",
                                ),

                                style: ElevatedButton.styleFrom(

                                  elevation: 0,

                                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                                      ? const Color(0xFF2A2A2A)
                                      : Colors.white,

                                  foregroundColor: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : const Color(0xFF2563EB),

                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),

                                ),

                              ),

                            ),
                        const SizedBox(height: 26),

                      Center(

                        child: Text(

                          "UniSphere v1.0.0",

                          style: TextStyle(

                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,

                            fontWeight: FontWeight.w600,

                          ),

                        ),

                      ),

                      const SizedBox(height: 8),

                      Center(

                        child: Text(

                          "Built with Flutter & Firebase",

                          style: TextStyle(

                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade500
                                : Colors.grey.shade600,

                            fontSize: 12,

                          ),

                        ),

                      ),

                      const SizedBox(height: 24),

                      ],

                    ),

                ),

              ],
            ),
          ),
        ),

        ),

    );

  }

}