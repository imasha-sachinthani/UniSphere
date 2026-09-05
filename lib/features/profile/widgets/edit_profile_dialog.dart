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

  File? selectedImage;

  bool isUploading = false;

  String existingImageUrl = "";

  String? selectedFaculty;
  String? selectedYear;

  final List<String> faculties = [
    "Computing",
    "Business",
    "Engineering",
    "Science",
    "Design",
    "Law",
  ];

  final List<String> years = [
    "Year 1",
    "Year 2",
    "Year 3",
    "Year 4",
  ];

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

    selectedFaculty = widget.profile.faculty.isEmpty
        ? null
        : widget.profile.faculty;

    selectedYear = widget.profile.year.isEmpty
        ? null
        : widget.profile.year;

    existingImageUrl = widget.profile.imageUrl;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
      faculty: selectedFaculty ?? "",
      year: selectedYear ?? "",
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
                    NetworkImage(existingImageUrl),
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
                    padding: EdgeInsets.only(top: 15),
                    child:
                    CircularProgressIndicator(),
                  ),

                const SizedBox(height: 25),

                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return "Full Name is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: emailController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value.length < 10) {
                      return "Invalid phone number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: selectedFaculty,
                  decoration: const InputDecoration(
                    labelText: "Faculty",
                    prefixIcon: Icon(Icons.school),
                  ),
                  items: faculties
                      .map(
                        (faculty) =>
                        DropdownMenuItem(
                          value: faculty,
                          child: Text(faculty),
                        ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFaculty = value;
                    });
                  },
                ),

                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: selectedYear,
                  decoration: const InputDecoration(
                    labelText:
                    "Academic Year",
                    prefixIcon:
                    Icon(Icons.calendar_today),
                  ),
                  items: years
                      .map(
                        (year) =>
                        DropdownMenuItem(
                          value: year,
                          child: Text(year),
                        ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
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

        ElevatedButton.icon(
          onPressed:
          isUploading ? null : save,
          icon: const Icon(Icons.save),
          label: Text(
            isUploading
                ? "Saving..."
                : "Save",
          ),
        ),
      ],
    );
  }
}