import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/notice_model.dart';

class NoticeDetailsDialog extends StatelessWidget {
  final NoticeModel notice;

  const NoticeDetailsDialog({
    super.key,
    required this.notice,
  });

  String getRelativeTime() {
    final difference =
    DateTime.now().difference(
      notice.createdAt,
    );

    if (difference.inMinutes < 1) {
      return "Just now";
    }

    if (difference.inHours < 1) {
      return "${difference.inMinutes} min ago";
    }

    if (difference.inDays == 0) {
      return "Today";
    }

    if (difference.inDays == 1) {
      return "Yesterday";
    }

    if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    }

    return DateFormat(
      "dd MMM yyyy",
    ).format(
      notice.createdAt,
    );
  }

  Color priorityColor() {
    switch (notice.priority) {
      case "Urgent":
        return Colors.red;

      case "Important":
        return Colors.orange;

      default:
        return Colors.green;
    }
  }

  Future<void> openAttachment() async {

    if (notice.attachmentUrl.isEmpty) {
      return;
    }

    final Uri url = Uri.parse(
      notice.attachmentUrl,
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode:
        LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20),
        ),

        child: ConstrainedBox(

            constraints:
            const BoxConstraints(
              maxWidth: 600,
            ),

            child: SingleChildScrollView(

                padding:
                const EdgeInsets.all(24),

                child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [            /// ---------------- TITLE ----------------

                  Text(
                  notice.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),

              const SizedBox(height: 20),

              /// ---------------- DEPARTMENT ----------------

              Row(
                children: [

                  const Icon(
                    Icons.apartment,
                    color: Colors.blue,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      notice.department,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// ---------------- CATEGORY & PRIORITY ----------------

              Wrap(
                spacing: 10,
                runSpacing: 10,

                children: [

                  Chip(
                    avatar: const Icon(
                      Icons.category,
                      size: 18,
                      color: Colors.blue,
                    ),
                    label: Text(
                      notice.category,
                    ),
                  ),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: priorityColor()
                          .withValues(alpha: 0.12),
                      borderRadius:
                      BorderRadius.circular(30),
                    ),

                    child: Row(
                      mainAxisSize:
                      MainAxisSize.min,

                      children: [

                        Icon(
                          Icons.circle,
                          size: 10,
                          color: priorityColor(),
                        ),

                        const SizedBox(width: 6),

                        Text(
                          notice.priority,
                          style: TextStyle(
                            color: priorityColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (notice.pinned)

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius:
                        BorderRadius.circular(30),
                      ),

                      child: const Row(
                        mainAxisSize:
                        MainAxisSize.min,

                        children: [

                          Icon(
                            Icons.push_pin,
                            size: 16,
                            color: Colors.red,
                          ),

                          SizedBox(width: 6),

                          Text(
                            "Pinned",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 24),

              /// ---------------- PUBLISHED INFO ----------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: Column(
                  children: [

                    Row(
                      children: [

                        const Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            notice.publishedBy,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [

                        Icon(
                          Icons.schedule,
                          color:
                          Colors.grey.shade700,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            getRelativeTime(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        Icon(
                          Icons.calendar_month,
                          color:
                          Colors.grey.shade700,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            DateFormat(
                              "dd MMM yyyy • hh:mm a",
                            ).format(
                              notice.createdAt,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),            /// ---------------- DESCRIPTION ----------------

                      const Text(
                        "Notice Description",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        notice.description,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.7,
                          color: Colors.grey.shade800,
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// ---------------- ATTACHMENT ----------------

                      if (notice.attachmentUrl.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius:
                            BorderRadius.circular(14),
                          ),

                          child: Row(
                            children: [

                              const CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(width: 14),

                              const Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "Attachment",
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 4),

                                    Text(
                                      "Download attached document",
                                    ),
                                  ],
                                ),
                              ),

                              ElevatedButton.icon(

                                onPressed: openAttachment,

                                icon: const Icon(
                                  Icons.download,
                                ),

                                label: const Text(
                                  "Download",
                                ),

                                style:
                                ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Colors.blue,
                                  foregroundColor:
                                  Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 28),

                      /// ---------------- CLOSE BUTTON ----------------

                      SizedBox(
                        width: double.infinity,
                        height: 48,

                        child: OutlinedButton(

                          onPressed: () {

                            Navigator.pop(context);

                          },

                          style: OutlinedButton.styleFrom(
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),

                          child: const Text(
                            "Close",
                          ),
                        ),
                      ),
                    ],
                ),
            ),
        ),
    );
  }

}