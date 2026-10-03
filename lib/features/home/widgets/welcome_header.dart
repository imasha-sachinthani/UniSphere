import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../profile/screens/profile_screen.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfile() {
    final user = FirebaseAuth.instance.currentUser;

    return FirebaseFirestore.instance
        .collection("profiles")
        .doc(user!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: getProfile(),
      builder: (context, snapshot) {
        String fullName = "Student";
        String imageUrl = "";

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data();

          if (data != null) {
            fullName = data["fullName"] ?? "Student";
            imageUrl = data["imageUrl"] ?? "";
          }
        }

        return Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 28,
                backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF1E1E1E)
                    : Colors.blue.shade100,
                backgroundImage:
                imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                child: imageUrl.isEmpty
                    ? const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.blue,
                )
                    : null,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning 👋",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        );
      },
    );
  }
}