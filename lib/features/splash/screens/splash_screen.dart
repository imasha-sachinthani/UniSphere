import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../authentication/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school_rounded,
                size: 90,
              ),

              const SizedBox(height: 24),

              Text(
                'UniSphere',
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 8),

              Text(
                'Everything a University Student Needs',
                style: AppTextStyles.body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}