import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';
import '../models/user_profile_model.dart';

class EditProfileDialog extends StatefulWidget {
  final UserProfileModel profile;

  const EditProfileDialog({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfileDialog> createState() =>
      _EditProfileDialogState();
}

class _EditProfileDialogState
    extends State<EditProfileDialog> {

  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController facultyController;
  late TextEditingController yearController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
            text: widget.profile.fullName);

    emailController =
        TextEditingController(
            text: widget.profile.email);

    phoneController =
        TextEditingController(
            text: widget.profile.phone);

    facultyController =
        TextEditingController(
            text: widget.profile.faculty);

    yearController =
        TextEditingController(
            text: widget.profile.year);

    imageController =
        TextEditingController(
            text: widget.profile.imageUrl);
  }

  Future<void> save() async {

    if (!formKey.currentState!.validate()) {
      return;
    }

    final profile = UserProfileModel(
      uid: widget.profile.uid,
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      faculty: facultyController.text.trim(),
      year: yearController.text.trim(),
      imageUrl: imageController.text.trim(),
    );

    await ProfileController.saveProfile(profile);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text("Edit Profile"),

      content: SizedBox(
        width: 430,

        child: Form(
          key: formKey,

          child: SingleChildScrollView(

            child: Column(

              children: [

                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: facultyController,
                  decoration: const InputDecoration(
                    labelText: "Faculty",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: yearController,
                  decoration: const InputDecoration(
                    labelText: "Academic Year",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    labelText: "Profile Image URL",
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: save,
          child: const Text("Save"),
        ),

      ],
    );
  }
}