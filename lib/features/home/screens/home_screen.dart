import 'package:flutter/material.dart';

import '../widgets/dashboard_overview.dart';
import '../widgets/feature_grid.dart';
import '../widgets/search_box.dart';
import '../widgets/welcome_header.dart';
import '../../marketplace/screens/marketplace_screen.dart';
import '../../lost_found/screens/lost_found_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(

        backgroundColor:
        const Color(0xffF5F7FB),

        body: SafeArea(

            child: RefreshIndicator(

                onRefresh: () async {

                  await Future.delayed(
                    const Duration(
                      milliseconds: 700,
                    ),
                  );

                },

                child: SingleChildScrollView(

                  physics:
                  const AlwaysScrollableScrollPhysics(),

                  padding:
                  const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    30,
                  ),

                  child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                      /// ====================================
                      /// HEADER
                      /// ====================================

                      const WelcomeHeader(),

                  const SizedBox(height: 28),

                  /// ====================================
                  /// SEARCH
                  /// ====================================

                  const SearchBox(),

                  const SizedBox(height: 28),

                  /// ====================================
                  /// TODAY
                  /// ====================================

                  Text(

                    "Today's Overview",

                    style:
                    theme.textTheme.titleLarge
                        ?.copyWith(

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 18),

                  const DashboardOverview(),

                  const SizedBox(height: 30),

                  /// ====================================
                  /// QUICK ACTIONS
                  /// ====================================

                  Text(

                    "Quick Actions",

                    style:
                    theme.textTheme.titleLarge
                        ?.copyWith(

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 18),

                  const FeatureGrid(),
                  const SizedBox(height: 32),

                  /// ====================================
                  /// MARKETPLACE PREVIEW
                  /// ====================================

                  Text(
                    "Marketplace",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const MarketplaceScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.05,
                            ),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [

                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple
                                  .withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.storefront_rounded,
                              color: Colors.deepPurple,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 18),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "Student Marketplace",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Text(
                                  "Buy, sell and discover items shared by students.",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// ====================================
                  /// LOST & FOUND PREVIEW
                  /// ====================================

                  Text(
                    "Lost & Found",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const LostFoundScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.05,
                            ),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [

                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(
                                alpha: 0.12,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 18),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "Lost & Found",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Text(
                                  "Report or find lost belongings within the university.",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                        const SizedBox(height: 40),

                      ],
                  ),
                ),
            ),
        ),
    );
  }
}