import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../core/services/storage_service.dart';
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

  File? selectedImage;

  bool isUploading = false;

  String existingImageUrl = "";

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.profile.fullName,
    );

    emailController = TextEditingController(
      text: widget.profile.email,
    );

    phoneController = TextEditingController(
      text: widget.profile.phone,
    );

    facultyController = TextEditingController(
      text: widget.profile.faculty,
    );

    yearController = TextEditingController(
      text: widget.profile.year,
    );

    existingImageUrl = widget.profile.imageUrl;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    facultyController.dispose();
    yearController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final image =
    await ImagePickerService.pickImage();

    if (image == null) return;

    setState(() {
      selectedImage = image;
    });
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isUploading = true;
    });

    String imageUrl = existingImageUrl;

    if (selectedImage != null) {
      imageUrl =
      await StorageService.uploadImage(
        selectedImage!,
        "profile",
      );
    }

    final profile = UserProfileModel(
      uid: widget.profile.uid,
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      faculty: facultyController.text.trim(),
      year: yearController.text.trim(),
      imageUrl: imageUrl,
    );

    await ProfileController.saveProfile(profile);

    if (!mounted) return;

    Navigator.pop(context);
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

                if (selectedImage != null)
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                    FileImage(selectedImage!),
                  )
                else if (existingImageUrl.isNotEmpty)
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                    NetworkImage(
                      existingImageUrl,
                    ),
                  )
                else
                  const CircleAvatar(
                    radius: 60,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),

                const SizedBox(height: 15),

                OutlinedButton.icon(
                  onPressed:
                  isUploading ? null : pickImage,
                  icon: const Icon(Icons.photo),
                  label: const Text(
                    "Choose Profile Photo",
                  ),
                ),

                if (isUploading)
                  const Padding(
                    padding:
                    EdgeInsets.only(top: 15),
                    child:
                    CircularProgressIndicator(),
                  ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: nameController,
                  decoration:
                  const InputDecoration(
                    labelText: "Full Name",
                  ),
                  validator: (value) =>
                  value == null ||
                      value.trim().isEmpty
                      ? "Required"
                      : null,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: emailController,
                  keyboardType:
                  TextInputType.emailAddress,
                  decoration:
                  const InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (value) =>
                  value == null ||
                      value.trim().isEmpty
                      ? "Required"
                      : null,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: phoneController,
                  keyboardType:
                  TextInputType.phone,
                  decoration:
                  const InputDecoration(
                    labelText: "Phone",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller:
                  facultyController,
                  decoration:
                  const InputDecoration(
                    labelText: "Faculty",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: yearController,
                  decoration:
                  const InputDecoration(
                    labelText:
                    "Academic Year",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      actions: [

        TextButton(
          onPressed: isUploading
              ? null
              : () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed:
          isUploading ? null : save,
          child: Text(
            isUploading
                ? "Uploading..."
                : "Save",
          ),
        ),
      ],
    );
  }
}