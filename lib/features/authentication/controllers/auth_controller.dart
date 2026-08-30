import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthController {
  AuthController._();

  static Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await AuthService.login(
        email: email.trim(),
        password: password.trim(),
      );

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> register({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (fullName.trim().isEmpty) {
      return "Please enter your full name";
    }

    if (email.trim().isEmpty) {
      return "Please enter your email";
    }

    if (password.isEmpty) {
      return "Please enter your password";
    }

    if (confirmPassword.isEmpty) {
      return "Please confirm your password";
    }

    if (password != confirmPassword) {
      return "Passwords do not match";
    }

    try {
      await AuthService.register(
        email: email.trim(),
        password: password.trim(),
      );

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> forgotPassword({
    required String email,
  }) async {
    if (email.trim().isEmpty) {
      return "Please enter your email";
    }

    try {
      await AuthService.forgotPassword(email.trim());

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> logout() async {
    await AuthService.logout();
  }
}