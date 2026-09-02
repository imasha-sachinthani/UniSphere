import 'package:flutter/material.dart';

import '../widgets/feature_grid.dart';
import '../widgets/search_box.dart';
import '../widgets/welcome_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("UniSphere"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const WelcomeHeader(),

              const SizedBox(height: 25),

              const SearchBox(),

              const SizedBox(height: 30),

              const FeatureGrid(),

            ],
          ),
        ),
      ),
    );
  }
}