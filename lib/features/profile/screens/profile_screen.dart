import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../settings/screens/settings_screen.dart';
import '../controllers/profile_controller.dart';
import '../models/user_profile_model.dart';
import '../widgets/edit_profile_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<UserProfileModel?>(
        stream: ProfileController.getProfile(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("Profile Not Found"),
            );
          }

          final profile = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: isDark
                      ? const Color(0xFF232323)
                      : Colors.grey.shade200,
                  backgroundImage: profile.imageUrl.isNotEmpty
                      ? NetworkImage(profile.imageUrl)
                      : null,
                  child: profile.imageUrl.isEmpty
                      ? Icon(
                    Icons.person,
                    size: 60,
                    color: isDark
                        ? Colors.blue.shade200
                        : Colors.blue.shade100,
                  )
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  profile.fullName.isEmpty
                      ? "Unknown User"
                      : profile.fullName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Center(
                child: Text(
                  profile.email,
                  style: TextStyle(
                    color: isDark
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Card(
                color: isDark
                    ? const Color(0xFF232323)
                    : Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "Phone",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        profile.phone.isEmpty
                            ? "-"
                            : profile.phone,
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),

                    Divider(
                      height: 1,
                      color: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                    ),

                    ListTile(
                      leading: const Icon(
                        Icons.school,
                        color: Colors.deepPurple,
                      ),
                      title: Text(
                        "Faculty",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        profile.faculty.isEmpty
                            ? "-"
                            : profile.faculty,
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),

                    Divider(
                      height: 1,
                      color: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                    ),

                    ListTile(
                      leading: const Icon(
                        Icons.calendar_today,
                        color: Colors.orange,
                      ),
                      title: Text(
                        "Academic Year",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        profile.year.isEmpty
                            ? "-"
                            : profile.year,
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 50,
                child: ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? const Color(0xFF23263A)
                        : Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => EditProfileDialog(
                        profile: profile,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 50,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
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
                              Navigator.pop(context, false);
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await FirebaseAuth.instance.signOut();
                    }
                  },
                ),
              ),

              const SizedBox(height: 25),

              Center(
                child: Text(
                  "UniSphere v1.0.0",
                  style: TextStyle(
                    color: isDark
                        ? Colors.grey.shade500
                        : Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}