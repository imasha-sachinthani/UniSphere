import 'package:flutter/material.dart';

import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';
import '../widgets/add_notice_dialog.dart';
import '../widgets/notice_card.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notices"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<NoticeModel>>(
        stream: NoticeController.getNotices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No Notices Available",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final notices = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final notice = notices[index];

              return NoticeCard(
                notice: notice,
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddNoticeDialog(
                      notice: notice,
                    ),
                  );
                },
                onDelete: () async {
                  await NoticeController.deleteNotice(
                    notice.id,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddNoticeDialog(),
          );
        },
      ),
    );
  }
}