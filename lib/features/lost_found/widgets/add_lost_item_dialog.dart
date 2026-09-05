import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../core/services/storage_service.dart';
import '../controllers/lost_found_controller.dart';
import '../models/lost_found_model.dart';

class AddLostItemDialog extends StatefulWidget {
  final LostFoundModel? item;

  const AddLostItemDialog({
    super.key,
    this.item,
  });

  @override
  State<AddLostItemDialog> createState() =>
      _AddLostItemDialogState();
}

class _AddLostItemDialogState
    extends State<AddLostItemDialog> {

  final formKey = GlobalKey<FormState>();

  final titleController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final locationController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  File? selectedImage;

  bool isSaving = false;

  String existingImageUrl = "";

  String uid = "";
  String userName = "";
  String email = "";

  String? selectedCategory;
  String? selectedStatus;

  final List<String> categories = [
    "Phone",
    "Laptop",
    "Student ID",
    "Keys",
    "Bag",
    "Wallet",
    "Books",
    "Calculator",
    "Accessories",
    "Other",
  ];

  final List<String> statusList = [
    "Lost",
    "Found",
  ];

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {

      titleController.text =
          widget.item!.title;

      descriptionController.text =
          widget.item!.description;

      locationController.text =
          widget.item!.location;

      phoneController.text =
          widget.item!.phone;

      existingImageUrl =
          widget.item!.imageUrl;

      selectedCategory =
          widget.item!.category;

      selectedStatus =
          widget.item!.status;
    }

    loadCurrentUser();
  }

  @override
  void dispose() {

    titleController.dispose();

    descriptionController.dispose();

    locationController.dispose();

    phoneController.dispose();

    super.dispose();
  }

  Future<void> loadCurrentUser() async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    uid = user.uid;

    final doc =
    await FirebaseFirestore.instance
        .collection("profiles")
        .doc(uid)
        .get();

    if (!doc.exists) return;

    final data = doc.data()!;

    userName =
        data["fullName"] ?? "";

    email =
        data["email"] ?? "";

    if (widget.item == null) {

      phoneController.text =
          data["phone"] ?? "";
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> pickImage() async {

    final image =
    await ImagePickerService.pickImage();

    if (image == null) return;

    setState(() {
      selectedImage = image;
    });
  }

  Future<void> saveItem() async {

    if (!formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {
      isSaving = true;
    });

    String imageUrl =
        existingImageUrl;

    if (selectedImage != null) {

      imageUrl =
      await StorageService.uploadImage(
        selectedImage!,
        "lost_found",
      );
    }

    final item = LostFoundModel(

      id: widget.item?.id ?? "",

      uid: uid,

      userName: userName,

      email: email,

      phone:
      phoneController.text.trim(),

      title:
      titleController.text.trim(),

      description:
      descriptionController.text.trim(),

      category:
      selectedCategory ?? "Other",

      status:
      selectedStatus ?? "Lost",

      location:
      locationController.text.trim(),

      imageUrl: imageUrl,

      claimed:
      widget.item?.claimed ?? false,

      createdAt:
      widget.item?.createdAt ??
          DateTime.now(),
    );

    if (widget.item == null) {

      await LostFoundController
          .addItem(item);

    } else {

      await LostFoundController
          .updateItem(
        widget.item!.id,
        item,
      );
    }

    if (!mounted) return;

    Navigator.pop(context);
  }  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          widget.item == null
              ? "Report Item"
              : "Edit Item",
        ),

        content: SizedBox(
            width: 430,

            child: Form(
              key: formKey,

              child: SingleChildScrollView(
                  child: Column(
                      children: [

                      /// ---------- IMAGE ----------

                      if (selectedImage != null)

                  ClipRRect(
                  borderRadius:
                  BorderRadius.circular(14),

              child: Image.file(
                selectedImage!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )

            else if (existingImageUrl.isNotEmpty)

        ClipRRect(
        borderRadius:
        BorderRadius.circular(14),

    child: Image.network(
    existingImageUrl,
    height: 180,
    width: double.infinity,
    fit: BoxFit.cover,

    errorBuilder:
    (_, __, ___) {
    return Container(
    height: 180,
    color:
    Colors.grey.shade300,

    child: const Center(
    child: Icon(
    Icons
        .broken_image,
    size: 60,
    ),
    ),
    );
    },
    ),
    )

    else

    Container(
    height: 180,
    width: double.infinity,

    decoration: BoxDecoration(
    color:
    Colors.grey.shade200,

    borderRadius:
    BorderRadius.circular(
    14,
    ),
    ),

    child: const Center(
    child: Icon(
    Icons.image,
    size: 70,
    color: Colors.grey,
    ),
    ),
    ),

    const SizedBox(height: 16),

    OutlinedButton.icon(

    onPressed:
    isSaving ? null : pickImage,

    icon:
    const Icon(Icons.photo),

    label: const Text(
    "Choose Image",
    ),
    ),

    if (isSaving)

    const Padding(
    padding:
    EdgeInsets.only(
    top: 15,
    ),
    child:
    CircularProgressIndicator(),
    ),

    const SizedBox(height: 20),

    /// ---------- ITEM NAME ----------

    TextFormField(

    controller:
    titleController,

    decoration:
    const InputDecoration(
    labelText:
    "Item Name",

    prefixIcon:
    Icon(Icons.inventory),
    ),

    validator: (value) {

    if (value == null ||
    value.trim().isEmpty) {

    return "Item name is required";
    }

    return null;
    },
    ),

    const SizedBox(height: 16),

    /// ---------- DESCRIPTION ----------

    TextFormField(

    controller:
    descriptionController,

    maxLines: 3,

    decoration:
    const InputDecoration(

    labelText:
    "Description",

    prefixIcon:
    Icon(Icons.description),
    ),
    ),

    const SizedBox(height: 16),

    /// ---------- LOCATION ----------

    TextFormField(

    controller:
    locationController,

    decoration:
    const InputDecoration(

    labelText:
    "Location",

    prefixIcon:
    Icon(Icons.location_on),
    ),

    validator: (value) {

    if (value == null ||
    value.trim().isEmpty) {

    return "Location is required";
    }

    return null;
    },
    ),

    const SizedBox(height: 16),

    /// ---------- CATEGORY ----------

    DropdownButtonFormField<String>(

    value: selectedCategory,

    decoration:
    const InputDecoration(

    labelText:
    "Category",

    prefixIcon:
    Icon(Icons.category),
    ),

    items: categories
        .map(
    (category) =>
    DropdownMenuItem(
    value: category,
    child:
    Text(category),
    ),
    )
        .toList(),

    onChanged: (value) {

    setState(() {

    selectedCategory =
    value;

    });
    },
    ),

    const SizedBox(height: 16),

    /// ---------- STATUS ----------

    DropdownButtonFormField<String>(

    value: selectedStatus,

    decoration:
    const InputDecoration(

    labelText:
    "Status",

    prefixIcon:
    Icon(Icons.flag),
    ),

    items: statusList
        .map(
    (status) =>
    DropdownMenuItem(
    value: status,
    child:
    Text(status),
    ),
    )
        .toList(),

    onChanged: (value) {

    setState(() {

    selectedStatus =
    value;

    });
    },
    ),

    const SizedBox(height: 16),

    /// ---------- PHONE ----------

    TextFormField(

    controller:
    phoneController,

    keyboardType:
    TextInputType.phone,

    decoration:
    const InputDecoration(

    labelText:
    "Phone Number",

    prefixIcon:
    Icon(Icons.phone),
    ),
    ),                const SizedBox(height: 20),

                        /// ---------- OWNER INFORMATION ----------

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius:
                            BorderRadius.circular(14),
                          ),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              const Text(
                                "Owner Information",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 14),

                              Row(
                                children: [

                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor:
                                    Colors.blue.shade100,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [

                                        Text(
                                          userName.isEmpty
                                              ? "Loading..."
                                              : userName,
                                          style:
                                          const TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 4,
                                        ),

                                        Text(
                                          email,
                                          style: TextStyle(
                                            color: Colors
                                                .grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                  ),
              ),
            ),
        ),

      actions: [

        TextButton(
          onPressed: isSaving
              ? null
              : () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
          ),
        ),

        ElevatedButton.icon(

          onPressed:
          isSaving ? null : saveItem,

          icon: isSaving
              ? const SizedBox(
            width: 18,
            height: 18,
            child:
            CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Icon(
            widget.item == null
                ? Icons.add
                : Icons.save,
          ),

          label: Text(
            isSaving
                ? "Saving..."
                : widget.item == null
                ? "Report Item"
                : "Update Item",
          ),

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}