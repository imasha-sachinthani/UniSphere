import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/theme_provider.dart';
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),

      body: ListView(

        children: [

      Consumer<ThemeProvider>(
      builder: (
      context,
        themeProvider,
        child,
      ) {

    return SwitchListTile(

      activeColor: Colors.white,
      activeTrackColor: const Color(0xFF0D47A1),
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.shade700,

    secondary: const Icon(
    Icons.dark_mode,
    ),

    title: const Text(
    "Dark Mode",
    ),

    subtitle: Text(
    themeProvider.isDark
    ? "Dark Theme Enabled"
        : "Light Theme Enabled",
    ),

    value: themeProvider.isDark,

    onChanged: (value) async {
    await themeProvider.toggleTheme(
    value,
    );
    },
    );
    },
    ),

          Divider(
            height: 1,
            color: isDark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
          ),

    SwitchListTile(

      activeColor: Colors.white,
      activeTrackColor: const Color(0xFF0D47A1),
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.shade700,

    secondary: const Icon(
    Icons.notifications,
    ),

    title: const Text(
    "Notifications",
    ),

    subtitle: const Text(
    "Receive app notifications",
    ),

    value: notifications,

    onChanged: (value) {
    setState(() {
    notifications = value;
    });
    },
    ),

          Divider(
            height: 1,
            color: isDark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
          ),

    ListTile(

    leading: const Icon(
    Icons.info,
    ),

    title: const Text(
    "About App",
    ),

      subtitle: Text(
        "UniSphere v1.0.0",
        style: TextStyle(
          color: isDark
              ? Colors.grey.shade400
              : Colors.grey.shade600,
        ),
      ),

      trailing: Icon(
        Icons.chevron_right,
        color: isDark
            ? Colors.grey.shade400
            : Colors.grey.shade700,
      ),

    onTap: () {

      showAboutDialog(
        context: context,
        applicationName: "UniSphere",
        applicationVersion: "1.0.0",
        applicationLegalese: "Developed for NSBM Students",
        barrierColor: Colors.black54,
      );
    },
    ),

          Divider(
            height: 1,
            color: isDark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
          ),

    ListTile(

    leading: const Icon(
    Icons.privacy_tip,
    ),

    title: const Text(
    "Privacy Policy",
    ),

      trailing: Icon(
        Icons.chevron_right,
        color: isDark
            ? Colors.grey.shade400
            : Colors.grey.shade700,
      ),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PrivacyPolicyScreen(),
          ),
        );
      },
    ),

          Divider(
            height: 1,
            color: isDark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
          ),

          ListTile(

            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),

            title: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
              ),
            ),

            onTap: () async {

              final confirm =
              await showDialog<bool>(

                context: context,

                builder: (_) => AlertDialog(
                  backgroundColor: isDark
                      ? const Color(0xFF232323)
                      : Colors.white,

                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),

                  content: Text(
                    "Are you sure you want to logout?",
                    style: TextStyle(
                      color: isDark
                          ? Colors.grey.shade300
                          : Colors.black87,
                    ),
                  ),
                  actions: [

                    TextButton(

                      onPressed: () {
                        Navigator.pop(
                          context,
                          false,
                        );
                      },

                      child: const Text(
                        "Cancel",
                      ),
                    ),

                    ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),

                      onPressed: () {
                        Navigator.pop(
                          context,
                          true,
                        );
                      },

                      child: const Text(
                        "Logout",
                      ),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await FirebaseAuth.instance
                    .signOut();
              }
            },
          ),

          const SizedBox(height: 40),

          const Center(
            child: Text(
              "UniSphere",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(
                color: isDark
                    ? Colors.grey.shade500
                    : Colors.grey.shade600,
              ),
            ),
          ),

          const SizedBox(height: 30),

        ],
      ),
    );
  }
}