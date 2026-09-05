import 'package:flutter/material.dart';

import '../../assignments/screens/assignment_screen.dart';
import '../../lost_found/screens/lost_found_screen.dart';
import '../../marketplace/screens/marketplace_screen.dart';
import '../../notices/screens/notices_screen.dart';
import '../../timetable/screens/timetable_screen.dart';
import 'home_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [

    HomeScreen(),

    TimetableScreen(),

    AssignmentScreen(),

    NoticesScreen(),

    MarketplaceScreen(),

    LostFoundScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: "Time",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: "Tasks",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_rounded),
            label: "News",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_rounded),
            label: "Market",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Lost",
          ),
        ],
      ),
    );
  }
}