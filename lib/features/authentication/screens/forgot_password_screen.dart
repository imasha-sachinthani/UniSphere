import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final TextEditingController emailController =
  TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
                  Icon(
                    Icons.lock_reset,
                    size: 90,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Forgot Password',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Enter your university email',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),

                  const SizedBox(height: 40),

                  AuthTextField(
                    controller: emailController,
                    hintText: 'University Email',
                    prefixIcon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 30),

                  AuthButton(
                    text: 'SEND RESET LINK',
                    onPressed: () {},
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