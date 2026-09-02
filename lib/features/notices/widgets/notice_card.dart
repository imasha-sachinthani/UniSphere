import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/notice_model.dart';

class NoticeCard extends StatelessWidget {
  final NoticeModel notice;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoticeCard({
    super.key,
    required this.notice,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Expanded(
                  child: Text(
                    notice.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                if (notice.pinned)
                  const Icon(
                    Icons.push_pin,
                    color: Colors.red,
                  ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "edit") {
                      onEdit();
                    } else {
                      onDelete();
                    }
                  },
                  itemBuilder: (_) => const [

                    PopupMenuItem(
                      value: "edit",
                      child: Text("Edit"),
                    ),

                    PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    ),

                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            Chip(
              label: Text(notice.category),
            ),

            const SizedBox(height: 10),

            Text(
              notice.description,
            ),

            const SizedBox(height: 15),

            Text(
              DateFormat("dd MMM yyyy").format(notice.date),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}