import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue.shade100,
          child: const Icon(
            Icons.person,
            size: 30,
            color: Colors.blue,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning 👋",
                style: AppTextStyles.body,
              ),

              const SizedBox(height: 4),

              Text(
                "Imasha",
                style: AppTextStyles.heading,
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        )
      ],
    );
  }
}