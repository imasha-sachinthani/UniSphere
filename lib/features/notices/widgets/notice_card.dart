import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/notice_model.dart';
import 'notice_details_dialog.dart';

class NoticeCard extends StatelessWidget {
  final NoticeModel notice;

  const NoticeCard({
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

  IconData categoryIcon() {
    switch (notice.category) {
      case "Exam":
        return Icons.school;

      case "Assignment":
        return Icons.assignment;

      case "Academic":
        return Icons.menu_book;

      case "Event":
        return Icons.celebration;

      case "Holiday":
        return Icons.beach_access;

      case "Career":
        return Icons.work;

      case "Emergency":
        return Icons.warning;

      default:
        return Icons.campaign;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,

        margin: const EdgeInsets.only(
          bottom: 18,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(18),
        ),

        child: Padding(
            padding:
            const EdgeInsets.all(18),

            child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [            /// ---------------- HEADER ----------------

              Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                CircleAvatar(
                  radius: 24,
                  backgroundColor:
                  Colors.blue.shade50,
                  child: Icon(
                    categoryIcon(),
                    color: Colors.blue,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        notice.title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [

                          Icon(
                            Icons.apartment,
                            size: 16,
                            color: Colors
                                .grey.shade600,
                          ),

                          const SizedBox(width: 5),

                          Expanded(
                            child: Text(
                              notice.department,
                              style: TextStyle(
                                color: Colors
                                    .grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                if (notice.pinned)

                  Container(
                    padding:
                    const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: Colors.red
                          .shade50,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.push_pin,
                      color: Colors.red,
                      size: 20,
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
                  avatar: Icon(
                    categoryIcon(),
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
                    BorderRadius.circular(
                      30,
                    ),
                  ),

                  child: Row(
                    mainAxisSize:
                    MainAxisSize.min,

                    children: [

                      Icon(
                        Icons.circle,
                        size: 10,
                        color:
                        priorityColor(),
                      ),

                      const SizedBox(width: 6),

                      Text(
                        notice.priority,
                        style: TextStyle(
                          color:
                          priorityColor(),
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// ---------------- DESCRIPTION ----------------

            Text(
              notice.description,
              maxLines: 3,
              overflow:
              TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color:
                Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 16),

            /// ---------------- ATTACHMENT ----------------

            if (notice.attachmentUrl
            .isNotEmpty)

      Container(
      width: double.infinity,

      padding:
      const EdgeInsets.all(
        14,
      ),

      decoration: BoxDecoration(
        color:
        Colors.blue.shade50,

        borderRadius:
        BorderRadius.circular(
          12,
        ),
      ),

      child: const Row(
        children: [

          Icon(
            Icons.attach_file,
            color: Colors.blue,
          ),

          SizedBox(width: 8),

          Expanded(
            child: Text(
              "Attachment Available",
            ),
          ),
        ],
      ),
    ),

    if (notice.attachmentUrl
        .isNotEmpty)

    const SizedBox(height: 18),            /// ---------------- FOOTER ----------------

                  const Divider(height: 28),

                  Row(
                    children: [

                      Icon(
                        Icons.schedule,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        getRelativeTime(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const Spacer(),

                      Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),

                      const SizedBox(width: 6),

                      Flexible(
                        child: Text(
                          notice.publishedBy,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ---------------- READ MORE ----------------

                  SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: ElevatedButton.icon(

                      icon: const Icon(
                        Icons.visibility,
                      ),

                      label: const Text(
                        "Read More",
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),

                      onPressed: () {

                        showDialog(
                          context: context,

                          builder: (_) =>
                              NoticeDetailsDialog(
                                notice: notice,
                              ),
                        );
                      },
                    ),
                  ),
                ],
            ),
        ),
    );
  }
}