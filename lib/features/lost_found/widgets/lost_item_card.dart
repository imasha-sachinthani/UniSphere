import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.imageUrl.isEmpty
                  ? Container(
                width: 90,
                height: 90,
                color: Colors.grey.shade300,
                child: const Icon(
                  Icons.image,
                  size: 40,
                ),
              )
                  : Image.network(
                item.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) {
                  return Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.broken_image,
                      size: 40,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    item.description,
                    maxLines: 2,
                    overflow:
                    TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 18,
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(
                          item.location,
                          overflow:
                          TextOverflow
                              .ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Chip(
                    label: Text(
                      item.claimed
                          ? "Claimed"
                          : "Available",
                    ),
                    backgroundColor:
                    item.claimed
                        ? Colors
                        .green.shade100
                        : Colors.orange
                        .shade100,
                  ),
                ],
              ),
            ),

            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "edit") {
                  onEdit();
                } else if (value == "delete") {
                  onDelete();
                }
              },
              itemBuilder: (context) => const [
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
      ),
    );
  }
}