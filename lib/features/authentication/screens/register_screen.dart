import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    final message = await AuthController.register(
      context: context,
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully!"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_add_alt_1_rounded,
                    size: 90,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Create your UniSphere account",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body,
                  ),

                  const SizedBox(height: 40),

                  AuthTextField(
                    controller: fullNameController,
                    hintText: "Full Name",
                    prefixIcon: Icons.person_outline,
                  ),

                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: emailController,
                    hintText: "University Email",
                    prefixIcon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: passwordController,
                    hintText: "Password",
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    prefixIcon: Icons.lock_reset_outlined,
                    obscureText: true,
                  ),

                  const SizedBox(height: 30),

                  isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : AuthButton(
                    text: "CREATE ACCOUNT",
                    onPressed: register,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}