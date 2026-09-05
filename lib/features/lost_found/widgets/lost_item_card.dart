import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/lost_found_controller.dart';
import '../models/lost_found_model.dart';

class LostItemCard extends StatelessWidget {
  final LostFoundModel item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LostItemCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  Future<void> contactOwner() async {
    if (item.phone.isEmpty) return;

    final Uri uri = Uri(
      scheme: "tel",
      path: item.phone,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  String getRelativeTime() {
    final difference =
    DateTime.now().difference(item.createdAt);

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
    ).format(item.createdAt);
  }

  IconData getCategoryIcon() {
    switch (item.category) {
      case "Phone":
        return Icons.smartphone;

      case "Laptop":
        return Icons.laptop;

      case "Student ID":
        return Icons.badge;

      case "Keys":
        return Icons.key;

      case "Bag":
        return Icons.backpack;

      case "Wallet":
        return Icons.wallet;

      case "Books":
        return Icons.menu_book;

      case "Calculator":
        return Icons.calculate;

      case "Accessories":
        return Icons.watch;

      default:
        return Icons.inventory_2;
    }
  }
  Color getCategoryColor() {
    switch (item.category) {
      case "Phone":
        return Colors.blue;

      case "Laptop":
        return Colors.deepPurple;

      case "Student ID":
        return Colors.indigo;

      case "Keys":
        return Colors.orange;

      case "Bag":
        return Colors.brown;

      case "Wallet":
        return Colors.green;

      case "Books":
        return Colors.teal;

      case "Calculator":
        return Colors.red;

      case "Accessories":
        return Colors.pink;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    final currentUser =
        FirebaseAuth.instance.currentUser;

    final isOwner =
        currentUser != null &&
            currentUser.uid == item.uid;

    return Card(
        elevation: 4,
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20),
        ),

        child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [            /// ---------------- IMAGE ----------------

            Stack(
            children: [

            ClipRRect(
            borderRadius:
                BorderRadius.circular(18),

          child: item.imageUrl.isEmpty

              ? Container(
            height: 190,
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),

              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  getCategoryColor().withValues(alpha: 0.08),
                  getCategoryColor().withValues(alpha: 0.18),
                ],
              ),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(
                  getCategoryIcon(),
                  size: 70,
                  color: getCategoryColor(),
                ),

                const SizedBox(height: 12),

                Text(
                  item.category,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: getCategoryColor(),
                  ),
                ),
              ],
            ),
          )

              : Image.network(

            item.imageUrl,

            height: 190,

            width: double.infinity,

            fit: BoxFit.cover,

            errorBuilder:
                (
                context,
                error,
                stackTrace,
                ) {

              return Container(
                height: 190,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),

                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      getCategoryColor().withValues(alpha: 0.08),
                      getCategoryColor().withValues(alpha: 0.18),
                    ],
                  ),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(
                      getCategoryIcon(),
                      size: 70,
                      color: getCategoryColor(),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      item.category,
                      style: TextStyle(
                        color: getCategoryColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        /// ---------- LOST / FOUND ----------

        Positioned(
          top: 12,
          left: 12,

          child: Container(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),

            decoration: BoxDecoration(

              color: item.status == "Lost"

                  ? Colors.red

                  : Colors.green,

              borderRadius:
              BorderRadius.circular(
                30,
              ),
            ),

            child: Text(

              item.status.toUpperCase(),

              style: const TextStyle(

                color: Colors.white,

                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),
        ),

        /// ---------- CLAIMED ----------

        if (item.claimed)

    Positioned(
      top: 12,
      right: 12,

      child: Container(

        padding:
        const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7,
        ),

        decoration: BoxDecoration(

          color: Colors.blue,

          borderRadius:
          BorderRadius.circular(
            30,
          ),
        ),

        child: const Text(

          "CLAIMED",

          style: TextStyle(

            color: Colors.white,

            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    ),
    ],
    ),

    const SizedBox(height: 18),

    /// ---------- TITLE ----------

    Row(
    children: [

    Expanded(
    child: Text(

    item.title,

    style: const TextStyle(

    fontSize: 22,

    fontWeight:
    FontWeight.bold,
    ),
    ),
    ),

    if (isOwner)

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

    Text(

    item.description,

    maxLines: 3,

    overflow:
    TextOverflow.ellipsis,

    style: TextStyle(

    color: Colors.grey.shade700,

    height: 1.5,
    ),
    ),

    const SizedBox(height: 20),            /// ---------- LOCATION ----------

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius:
                      BorderRadius.circular(14),
                    ),

                    child: Row(
                      children: [

                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            item.location,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight:
                              FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ---------- OWNER ----------

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
                                    item.userName,
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
                                    item.email,
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

                        const SizedBox(height: 16),

                        Row(
                          children: [

                            const Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                item.phone.isEmpty
                                    ? "Phone number not available"
                                    : item.phone,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ---------- CONTACT BUTTON ----------

                  SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: ElevatedButton.icon(

                      onPressed:
                      item.phone.isEmpty
                          ? null
                          : contactOwner,

                      icon: const Icon(
                        Icons.call,
                      ),

                      label: const Text(
                        "Contact Owner",
                      ),

                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.blue,
                        foregroundColor:
                        Colors.white,
                        elevation: 0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// ---------- FOOTER ----------

                  Row(
                    children: [

                      Icon(
                        Icons.schedule,
                        size: 18,
                        color:
                        Colors.grey.shade600,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        getRelativeTime(),
                        style: TextStyle(
                          color: Colors
                              .grey.shade600,
                        ),
                      ),

                      const Spacer(),

                      if (isOwner)

                        Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color:
                            Colors.blue.shade50,
                            borderRadius:
                            BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Text(
                            "Your Post",
                            style: TextStyle(
                              color:
                              Colors.blue.shade700,
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
            ),
        ),
    );
  }
}