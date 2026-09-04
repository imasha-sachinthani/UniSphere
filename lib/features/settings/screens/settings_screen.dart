import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/theme_provider.dart';

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

    return Scaffold(

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

    const Divider(height: 1),

    SwitchListTile(

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

    const Divider(height: 1),

    ListTile(

    leading: const Icon(
    Icons.info,
    ),

    title: const Text(
    "About App",
    ),

    subtitle: const Text(
    "UniSphere v1.0.0",
    ),

    trailing: const Icon(
    Icons.chevron_right,
    ),

    onTap: () {

    showAboutDialog(

    context: context,

    applicationName:
    "UniSphere",

    applicationVersion:
    "1.0.0",

    applicationLegalese:
    "Developed for NSBM Students",
    );
    },
    ),

    const Divider(height: 1),

    ListTile(

    leading: const Icon(
    Icons.privacy_tip,
    ),

    title: const Text(
    "Privacy Policy",
    ),

    trailing: const Icon(
    Icons.chevron_right,
    ),

    onTap: () {

    ScaffoldMessenger.of(context)
        .showSnackBar(

    const SnackBar(

    content: Text(
    "Privacy Policy coming soon.",
    ),
    ),
    );
    },
    ),

    const Divider(height: 1),

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

                  title: const Text(
                    "Logout",
                  ),

                  content: const Text(
                    "Are you sure you want to logout?",
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
                color: Colors.grey.shade600,
              ),
            ),
          ),

          const SizedBox(height: 30),

        ],
      ),
    );
  }
}