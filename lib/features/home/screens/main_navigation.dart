import 'package:flutter/material.dart';

import '../../assignments/screens/assignment_screen.dart';
import '../../lost_found/screens/lost_found_screen.dart';
import '../../marketplace/screens/marketplace_screen.dart';
import '../../notices/screens/notices_screen.dart';
import '../../profile/screens/profile_screen.dart';
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
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Time",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Tasks",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: "Notices",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Market",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Lost",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}