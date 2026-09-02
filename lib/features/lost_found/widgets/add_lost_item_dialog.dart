import 'package:flutter/material.dart';

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
  final imageController =
  TextEditingController();

  bool claimed = false;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      titleController.text = widget.item!.title;
      descriptionController.text =
          widget.item!.description;
      locationController.text =
          widget.item!.location;
      imageController.text =
          widget.item!.imageUrl;
      claimed = widget.item!.claimed;
    }
  }

  Future<void> saveItem() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final item = LostFoundModel(
      id: widget.item?.id ?? "",
      title: titleController.text.trim(),
      description:
      descriptionController.text.trim(),
      location:
      locationController.text.trim(),
      imageUrl:
      imageController.text.trim(),
      claimed: claimed,
      createdAt:
      widget.item?.createdAt ??
          DateTime.now(),
    );

    if (widget.item == null) {
      await LostFoundController.addItem(item);
    } else {
      await LostFoundController.updateItem(
        widget.item!.id,
        item,
      );
    }

    if (mounted) {
      Navigator.pop(context);
    }
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
                  controller: titleController,
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
                    labelText: "Description",
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

                const SizedBox(height: 15),

                TextFormField(
                  controller:
                  imageController,
                  decoration:
                  const InputDecoration(
                    labelText: "Image URL",
                  ),
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
          onPressed: saveItem,
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