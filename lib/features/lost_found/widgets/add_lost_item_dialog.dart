import 'dart:io';

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

  final titleController = TextEditingController();
  final descriptionController =
  TextEditingController();
  final locationController =
  TextEditingController();

  File? selectedImage;

  bool claimed = false;
  bool isUploading = false;

  String existingImageUrl = "";

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

      existingImageUrl =
          widget.item!.imageUrl;

      claimed = widget.item!.claimed;
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
        "lost_found",
      );
    }

    final item = LostFoundModel(
      id: widget.item?.id ?? "",
      title: titleController.text.trim(),
      description:
      descriptionController.text.trim(),
      location:
      locationController.text.trim(),
      imageUrl: imageUrl,
      claimed: claimed,
      createdAt:
      widget.item?.createdAt ??
          DateTime.now(),
    );

    if (widget.item == null) {
      await LostFoundController.addItem(
        item,
      );
    } else {
      await LostFoundController
          .updateItem(
        widget.item!.id,
        item,
      );
    }

    if (mounted) {
      Navigator.pop(context);
    }

    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.item == null
            ? "Add Lost Item"
            : "Edit Lost Item",
      ),
      content: SizedBox(
        width: 430,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller:
                  titleController,
                  decoration:
                  const InputDecoration(
                    labelText: "Item Name",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller:
                  descriptionController,
                  maxLines: 3,
                  decoration:
                  const InputDecoration(
                    labelText:
                    "Description",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller:
                  locationController,
                  decoration:
                  const InputDecoration(
                    labelText:
                    "Found Location",
                  ),
                ),

                const SizedBox(height: 20),

                if (selectedImage != null)
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                        12),
                    child: Image.file(
                      selectedImage!,
                      height: 180,
                      width:
                      double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else if (existingImageUrl
                    .isNotEmpty)
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                        12),
                    child: Image.network(
                      existingImageUrl,
                      height: 180,
                      width:
                      double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context,
                          error,
                          stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors
                              .grey.shade300,
                          child: const Center(
                            child: Icon(
                              Icons
                                  .broken_image,
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 15),

                OutlinedButton.icon(
                  onPressed: pickImage,
                  icon: const Icon(
                    Icons.photo,
                  ),
                  label: const Text(
                    "Choose Image",
                  ),
                ),

                if (isUploading)
                  const Padding(
                    padding:
                    EdgeInsets.only(
                        top: 15),
                    child:
                    CircularProgressIndicator(),
                  ),

                const SizedBox(height: 10),

                CheckboxListTile(
                  value: claimed,
                  title:
                  const Text("Claimed"),
                  onChanged: (value) {
                    setState(() {
                      claimed =
                          value ?? false;
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
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed:
          isUploading ? null : saveItem,
          child: Text(
            widget.item == null
                ? "Save"
                : "Update",
          ),
        ),
      ],
    );
  }
}