import 'package:flutter/material.dart';

import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';

class AddNoticeDialog extends StatefulWidget {
  final NoticeModel? notice;

  const AddNoticeDialog({
    super.key,
    this.notice,
  });

  @override
  State<AddNoticeDialog> createState() => _AddNoticeDialogState();
}

class _AddNoticeDialogState extends State<AddNoticeDialog> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String category = "University";
  bool pinned = false;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.notice != null) {
      titleController.text = widget.notice!.title;
      descriptionController.text = widget.notice!.description;
      category = widget.notice!.category;
      pinned = widget.notice!.pinned;
      date = widget.notice!.date;
    }
  }

  Future<void> saveNotice() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final notice = NoticeModel(
      id: widget.notice?.id ?? "",
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      category: category,
      date: date,
      pinned: pinned,
    );

    if (widget.notice == null) {
      await NoticeController.addNotice(notice);
    } else {
      await NoticeController.updateNotice(
        widget.notice!.id,
        notice,
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
        widget.notice == null ? "Add Notice" : "Edit Notice",
      ),
      content: SizedBox(
        width: 420,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  initialValue: category,
                  decoration: const InputDecoration(
                    labelText: "Category",
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "University",
                      child: Text("University"),
                    ),
                    DropdownMenuItem(
                      value: "Faculty",
                      child: Text("Faculty"),
                    ),
                    DropdownMenuItem(
                      value: "Department",
                      child: Text("Department"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      category = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  value: pinned,
                  title: const Text("Pinned"),
                  onChanged: (value) {
                    setState(() {
                      pinned = value ?? false;
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
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: saveNotice,
          child: Text(
            widget.notice == null ? "Save" : "Update",
          ),
        ),
      ],
    );
  }
}