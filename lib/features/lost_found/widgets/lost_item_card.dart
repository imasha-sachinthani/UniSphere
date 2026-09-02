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
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.imageUrl.isEmpty
                  ? Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image),
              )
                  : Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(item.description),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.red,
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(item.location),
                      ),

                    ],
                  ),

                  const SizedBox(height: 8),

                  Chip(
                    label: Text(
                      item.claimed
                          ? "Claimed"
                          : "Available",
                    ),
                    backgroundColor: item.claimed
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                  ),
                ],
              ),
            ),

            PopupMenuButton(
              itemBuilder: (_) => [

                PopupMenuItem(
                  onTap: onEdit,
                  child: const Text("Edit"),
                ),

                PopupMenuItem(
                  onTap: onDelete,
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}