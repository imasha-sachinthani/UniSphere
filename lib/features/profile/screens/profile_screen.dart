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
                    builder: (_) =>
                    const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),

        body: StreamBuilder<UserProfileModel?>(
            stream:
            ProfileController.getProfile(uid),

            builder: (context, snapshot) {

              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child:
                  CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child:
                  Text("Profile Not Found"),
                );
              }

              final profile = snapshot.data!;

              return ListView(
                padding:
                const EdgeInsets.all(20),

                children: [

              Center(
              child: CircleAvatar(
              radius: 60,
                backgroundColor:
                Colors.grey.shade200,
                backgroundImage:
                profile.imageUrl
                    .isNotEmpty
                    ? NetworkImage(
                  profile
                      .imageUrl,
                )
                    : null,
                onBackgroundImageError:
                    (_, __) {},
                child:
                profile.imageUrl.isEmpty
                    ? const Icon(
                  Icons.person,
                  size: 60,
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
              style:
              const TextStyle(
              fontSize: 24,
              fontWeight:
              FontWeight.bold,
              ),
              ),
              ),

              const SizedBox(height: 6),

              Center(
              child: Text(
              profile.email,
              style: TextStyle(
              color: Colors
                  .grey.shade600,
              fontSize: 15,
              ),
              ),
              ),

              const SizedBox(height: 30),

              Card(
              elevation: 2,
              shape:
              RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
              16),
              ),
              child: Column(
              children: [

              ListTile(
              leading:
              const Icon(
              Icons.phone,
              color:
              Colors.blue,
              ),
              title: const Text(
              "Phone",
              ),
              subtitle: Text(
              profile.phone
                  .isEmpty
              ? "-"
                  : profile
                  .phone,
              ),
              ),

              const Divider(
              height: 1),

              ListTile(
              leading:
              const Icon(
              Icons.school,
              color: Colors
                  .deepPurple,
              ),
              title: const Text(
              "Faculty",
              ),
              subtitle: Text(
              profile.faculty
                  .isEmpty
              ? "-"
                  : profile
                  .faculty,
              ),
              ),

              const Divider(
              height: 1),

              ListTile(
              leading:
              const Icon(
              Icons
                  .calendar_today,
              color: Colors
                  .orange,
              ),
              title: const Text(
              "Academic Year",
              ),
              subtitle: Text(
              profile.year
                  .isEmpty
              ? "-"
                  : profile
                  .year,
              ),
              ),
              ],
              ),
              ),

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text(
                        "Edit Profile",
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              EditProfileDialog(
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
                                style:
                                ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Colors.red,
                                  foregroundColor:
                                  Colors.white,
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
                  ),

                  const SizedBox(height: 25),

                  Center(
                    child: Text(
                      "UniSphere v1.0.0",
                      style: TextStyle(
                        color: Colors.grey.shade600,
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