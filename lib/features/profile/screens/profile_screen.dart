import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';
import '../models/user_profile_model.dart';
import '../widgets/edit_profile_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: StreamBuilder<UserProfileModel?>(
        stream:
        ProfileController.getProfile(uid),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {

            return const Center(
              child: Text("Profile Not Found"),
            );
          }

          final profile = snapshot.data!;

          return ListView(

            padding:
            const EdgeInsets.all(20),

            children: [

              CircleAvatar(
                radius: 55,
                backgroundImage:
                profile.imageUrl.isEmpty
                    ? null
                    : NetworkImage(
                  profile.imageUrl,
                ),
                child: profile.imageUrl.isEmpty
                    ? const Icon(
                  Icons.person,
                  size: 55,
                )
                    : null,
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  profile.fullName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ListTile(
                leading: const Icon(Icons.email),
                title: Text(profile.email),
              ),

              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(profile.phone),
              ),

              ListTile(
                leading: const Icon(Icons.school),
                title: Text(profile.faculty),
              ),

              ListTile(
                leading:
                const Icon(Icons.calendar_today),
                title: Text(profile.year),
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(

                onPressed: () {

                  showDialog(
                    context: context,
                    builder: (_) =>
                        EditProfileDialog(
                          profile: profile,
                        ),
                  );
                },

                icon: const Icon(Icons.edit),

                label:
                const Text("Edit Profile"),
              ),

              const SizedBox(height: 15),

              ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),

                onPressed: () async {

                  await FirebaseAuth.instance
                      .signOut();
                },

                icon: const Icon(Icons.logout),

                label: const Text("Logout"),
              ),
            ],
          );
        },
      ),
    );
  }
}