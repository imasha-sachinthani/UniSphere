import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/marketplace_controller.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  IconData getCategoryIcon() {
    switch (product.category) {
      case "Books":
        return Icons.menu_book;

      case "Electronics":
        return Icons.devices;

      case "Furniture":
        return Icons.chair_alt;

      case "Clothing":
        return Icons.checkroom;

      case "Accessories":
        return Icons.watch;

      default:
        return Icons.inventory_2;
    }
  }

  Color getCategoryColor() {
    switch (product.category) {
      case "Books":
        return Colors.blue;

      case "Electronics":
        return Colors.deepPurple;

      case "Furniture":
        return Colors.brown;

      case "Clothing":
        return Colors.pink;

      case "Accessories":
        return Colors.orange;

      default:
        return Colors.teal;
    }
  }

  Future<void> callSeller() async {
    if (product.phone.isEmpty) return;

    final Uri uri = Uri(
      scheme: "tel",
      path: product.phone,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  String getRelativeTime() {
    final difference =
    DateTime.now().difference(product.createdAt);

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
    ).format(product.createdAt);
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final cardColor =
    isDark ? const Color(0xFF1E1E1E) : Colors.white;

    final currentUser =
        FirebaseAuth.instance.currentUser;

    final isOwner =
        currentUser != null &&
            currentUser.uid == product.uid;

    return StreamBuilder<bool>(
        stream: MarketplaceController.isFavorite(
          productId: product.id,
          userId: currentUser?.uid ?? "",
        ),

        builder: (context, snapshot) {

          final isFavorite =
              snapshot.data ?? false;

          return Card(
            color: cardColor,
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),

              shadowColor: Colors.black12,

              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20),
              ),

              child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [                /// ---------------- IMAGE ----------------

                  Stack(
                  children: [

                  ClipRRect(
                  borderRadius:
                    BorderRadius.circular(
                    18,
                  ),

                child: product
                    .imageUrl
                    .isEmpty

                    ? Container(
                  height: 190,
                  width:
                  double.infinity,

                  decoration:
                  BoxDecoration(
                    color:
                    getCategoryColor()
                        .withValues(
                      alpha: 0.08,
                    ),
                  ),

                  child: Center(
                    child: Icon(
                      getCategoryIcon(),
                      size: 70,
                      color:
                      getCategoryColor(),
                    ),
                  ),
                )

                    : Image.network(

                  product.imageUrl,

                  height: 190,

                  width:
                  double.infinity,

                  fit: BoxFit.cover,

                  errorBuilder:
                      (
                      context,
                      error,
                      stackTrace,
                      ) {

                    return Container(
                      height: 190,

                      color: isDark
                          ? const Color(0xFF2A2A2A)
                          : Colors.grey.shade300,

                      child:
                      const Center(
                        child: Icon(
                          Icons
                              .broken_image,
                          size: 70,
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// SOLD BADGE

              if (product.isSold)

          Positioned(
            left: 12,
            top: 12,

            child: Container(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 14,
                vertical: 7,
              ),

              decoration:
              BoxDecoration(
                color: Colors.red,

                borderRadius:
                BorderRadius
                    .circular(
                  30,
                ),
              ),

              child: const Text(
                "SOLD",

                style: TextStyle(
                  color:
                  Colors.white,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),

          /// FAVORITE BUTTON

          Positioned(
          top: 12,
          right: 12,

          child: CircleAvatar(
          radius: 22,

            backgroundColor:
            isDark
                ? const Color(0xFF2A2A2A)
                : Colors.white,

          child: IconButton(

          splashRadius: 20,

          onPressed: () {

          if (currentUser ==
          null) {
          return;
          }

          MarketplaceController
              .toggleFavorite(

          productId:
          product.id,

          userId:
          currentUser.uid,

          isFavorite:
          !isFavorite,
          );
          },

          icon: Icon(

          isFavorite

          ? Icons.favorite

              : Icons
              .favorite_border,

          color: Colors.red,
          ),
          ),
          ),
          ),
          ],
          ),

          const SizedBox(height: 18),

          /// ---------------- TITLE ----------------

          Row(
          children: [

          Expanded(
          child: Text(
            product.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          ),

          if (isOwner)

          PopupMenuButton<String>(

          onSelected: (value) {

          if (value ==
          "edit") {

          onEdit();

          } else {

          onDelete();

          }
          },

          itemBuilder: (_) => const [

          PopupMenuItem(
          value: "edit",
          child: Text(
          "Edit",
          ),
          ),

          PopupMenuItem(
          value: "delete",
          child: Text(
          "Delete",
          ),
          ),
          ],
          ),
          ],
          ),

          const SizedBox(height: 10),                Text(
          product.description,

          maxLines: 2,

          overflow:
          TextOverflow.ellipsis,

                          style: TextStyle(
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade700,
                            height: 1.5,
                            fontSize: 15,
                          ),
          ),

          const SizedBox(height: 18),

          /// ---------------- CATEGORY ----------------

          Wrap(
          spacing: 10,
          runSpacing: 10,

          children: [

          Chip(

          avatar: Icon(
          getCategoryIcon(),
          size: 18,
          color: getCategoryColor(),
          ),

          label: Text(
          product.category,
          ),

          backgroundColor:
          getCategoryColor().withValues(
          alpha: 0.10,
          ),
          ),

            Chip(
              avatar: Icon(
                product.condition == "New"
                    ? Icons.verified
                    : Icons.history,
                size: 18,
                color: product.condition == "New"
                    ? Colors.green
                    : Colors.orange,
              ),

              label: Text(
                product.condition,
                style: TextStyle(
                  color: isDark
                      ? Colors.white
                      : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),

              backgroundColor: product.condition == "New"
                  ? (isDark
                  ? Colors.green.withValues(alpha: 0.18)
                  : Colors.green.shade100)
                  : (isDark
                  ? Colors.deepOrange.withValues(alpha: 0.22)
                  : Colors.orange.shade100),
            ),
          ],
          ),

          const SizedBox(height: 20),

          /// ---------------- PRICE ----------------

          Container(

          width: double.infinity,

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(

            color: isDark
                ? Colors.green.withValues(alpha: 0.12)
                : Colors.green.shade50,

          borderRadius:
          BorderRadius.circular(16),

          border: Border.all(
            color: isDark
                ? Colors.green.withValues(alpha: 0.25)
                : Colors.green.shade100,
          ),
          ),

          child: Row(

          children: [

          Container(

          padding:
          const EdgeInsets.all(8),

          decoration: BoxDecoration(

          color: Colors.green,

          borderRadius:
          BorderRadius.circular(10),
          ),

          child: const Icon(

          Icons.currency_rupee,

          color: Colors.white,

          size: 18,
          ),
          ),

          const SizedBox(width: 12),

          Expanded(

          child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

          Text(

          "Price",

          style: TextStyle(
            color: isDark
                ? Colors.grey.shade400
                : Colors.grey.shade600,
          ),
          ),

          const SizedBox(height: 3),

          Text(

          "Rs. ${product.price.toStringAsFixed(0)}",

          style: const TextStyle(

          fontSize: 24,

          fontWeight:
          FontWeight.bold,

          color: Colors.green,
          ),
          ),
          ],
          ),
          ),
          ],
          ),
          ),

          const SizedBox(height: 20),

          /// ---------------- SELLER CARD ----------------

          Container(

          width: double.infinity,

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(

            color: isDark
                ? const Color(0xFF252525)
                : Colors.grey.shade100,

          borderRadius:
          BorderRadius.circular(16),
          ),

          child: Column(

          children: [

          Row(

          children: [

          CircleAvatar(

          radius: 25,

            backgroundColor: isDark
                ? Colors.blue.withValues(alpha: 0.20)
                : Colors.blue.shade100,

          child: const Icon(
          Icons.person,
          color: Colors.blue,
          ),
          ),

          const SizedBox(width: 12),

          Expanded(

          child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

          Text(

          product.sellerName,

          style: const TextStyle(

          fontSize: 17,

          fontWeight:
          FontWeight.bold,
          ),
          ),

          const SizedBox(height: 3),

          Text(

          product.sellerEmail,

          style: TextStyle(

            color: isDark
                ? Colors.grey.shade400
                : Colors.grey.shade600,

          fontSize: 13,
          ),
          ),
          ],
          ),
          ),
          ],
          ),                      const SizedBox(height: 16),

          /// ---------------- PHONE ----------------

          Row(
          children: [

          const Icon(
          Icons.phone,
          color: Colors.green,
          size: 20,
          ),

          const SizedBox(width: 10),

          Expanded(
          child: Text(
          product.phone.isEmpty
          ? "Phone number not available"
              : product.phone,
          style: const TextStyle(
          fontSize: 15,
          ),
          ),
          ),
          ],
          ),

          const SizedBox(height: 18),

          /// ---------------- CONTACT BUTTON ----------------

          SizedBox(
          width: double.infinity,
          height: 48,

          child: ElevatedButton.icon(

          onPressed: product.phone.isEmpty
          ? null
              : callSeller,

          icon: const Icon(
          Icons.call,
          ),

          label: const Text(
          "Contact Seller",
          ),

            style: ElevatedButton.styleFrom(
              backgroundColor: isDark
                  ? const Color(0xFF0D47A1)
                  : Colors.blue,

              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          ),
          ],
          ),
          ),

          const SizedBox(height: 20),

          /// ---------------- FOOTER ----------------

          Row(
          children: [

          Icon(
          Icons.schedule,
          size: 18,
            color: isDark
                ? Colors.grey.shade400
                : Colors.grey.shade600,
          ),

          const SizedBox(width: 6),

          Text(
          getRelativeTime(),
          style: TextStyle(
            color: isDark
                ? Colors.grey.shade400
                : Colors.grey.shade600,
          ),
          ),

          const Spacer(),                    if (isOwner)

          Container(
          padding:
          const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
          ),

          decoration: BoxDecoration(
            color: isDark
                ? Colors.blue.withValues(alpha: 0.15)
                : Colors.blue.shade50,

          borderRadius:
          BorderRadius.circular(
          20,
          ),
          ),

          child: Text(
          "Your Product",

          style: TextStyle(
            color: isDark
                ? Colors.blue.shade200
                : Colors.blue.shade700,

          fontWeight:
          FontWeight.bold,

          fontSize: 12,
          ),
          ),
          ),
          ],
          ),

          const SizedBox(height: 16),

          /// ---------------- OWNER ACTIONS ----------------

          if (isOwner)

          Row(
          children: [

          Expanded(
          child: OutlinedButton.icon(

          onPressed: onEdit,

          icon: const Icon(
          Icons.edit,
          ),

          label: const Text(
          "Edit",
          ),

          style:
          OutlinedButton.styleFrom(
          padding:
          const EdgeInsets.symmetric(
          vertical: 12,
          ),

          shape:
          RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
          12,
          ),
          ),
          ),
          ),
          ),

          const SizedBox(width: 12),

          Expanded(
          child: ElevatedButton.icon(

          onPressed: onDelete,

          icon: const Icon(
          Icons.delete,
          ),

          label: const Text(
          "Delete",
          ),

          style:
          ElevatedButton.styleFrom(

          backgroundColor:
          Colors.red,

          foregroundColor:
          Colors.white,

          padding:
          const EdgeInsets.symmetric(
          vertical: 12,
          ),

          shape:
          RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
          12,
          ),
          ),
          ),
          ),
          ),
          ],
          ),

          if (!isOwner)

          const SizedBox(height: 8),                /// ---------------- PRODUCT STATUS ----------------

          if (product.isSold)

          Container(
          width: double.infinity,

          margin:
          const EdgeInsets.only(
          top: 18,
          ),

          padding:
          const EdgeInsets.all(14),

          decoration: BoxDecoration(

            color: isDark
                ? Colors.red.withValues(alpha: 0.15)
                : Colors.red.shade50,
          borderRadius:
          BorderRadius.circular(
          14,
          ),

          border: Border.all(
            color: isDark
                ? Colors.red.withValues(alpha: 0.35)
                : Colors.red.shade200,
          ),
          ),

          child: const Row(

          children: [

          Icon(
          Icons.check_circle,
          color: Colors.red,
          ),

          SizedBox(width: 10),

          Expanded(
          child: Text(

          "This product has already been sold.",

          style: TextStyle(

          color: Colors.red,

          fontWeight:
          FontWeight.bold,
          ),
          ),
          ),
          ],
          ),
          )

          else

          Container(

          width: double.infinity,

          margin:
          const EdgeInsets.only(
          top: 18,
          ),

          padding:
          const EdgeInsets.all(
          14,
          ),

          decoration: BoxDecoration(

            color: isDark
                ? Colors.green.withValues(alpha: 0.15)
                : Colors.green.shade50,

          borderRadius:
          BorderRadius.circular(
          14,
          ),

          border: Border.all(
            color: isDark
                ? Colors.green.withValues(alpha: 0.35)
                : Colors.green.shade200,
          ),
          ),

          child: const Row(

          children: [

          Icon(
          Icons.sell,
          color: Colors.green,
          ),

          SizedBox(width: 10),

          Expanded(
          child: Text(

          "Available for purchase",

          style: TextStyle(

          color:
          Colors.green,

          fontWeight:
          FontWeight.bold,
          ),
          ),
          ),
          ],
          ),
          ),

          const SizedBox(height: 18),

          /// ---------------- PRODUCT INFO ----------------

          Row(
          children: [

          Expanded(
          child: Container(

          padding:
          const EdgeInsets.all(
          12,
          ),

          decoration:
          BoxDecoration(

            color: isDark
                ? Colors.blue.withValues(alpha: 0.15)
                : Colors.blue.shade50,

          borderRadius:
          BorderRadius.circular(
          12,
          ),
          ),

          child: Column(

          children: [

          const Icon(
          Icons.category,
          color: Colors.blue,
          ),

          const SizedBox(
          height: 8,
          ),

          const Text(
          "Category",
          style: TextStyle(
          fontSize: 12,
          ),
          ),

          const SizedBox(
          height: 4,
          ),

          Text(

          product.category,

          textAlign:
          TextAlign.center,

          style:
          const TextStyle(
          fontWeight:
          FontWeight.bold,
          ),
          ),
          ],
          ),
          ),
          ),

          const SizedBox(width: 12),                    Expanded(
              child: Container(
                padding:
                const EdgeInsets.all(
                  12,
                ),

                decoration:
                BoxDecoration(
                  color: isDark
                      ? Colors.orange.withValues(alpha: 0.15)
                      : Colors.orange.shade50,

                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),

                child: Column(
                  children: [

                    const Icon(
                      Icons.verified,
                      color: Colors.orange,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    const Text(
                      "Condition",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      product.condition,
                      textAlign:
                      TextAlign.center,
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          ),

                        const SizedBox(height: 20),

                        /// ---------------- PRODUCT ID ----------------

                        Align(
                          alignment:
                          Alignment.centerRight,
                          child: Text(
                            "ID : ${product.id.substring(0, product.id.length > 8 ? 8 : product.id.length)}",
                            style: TextStyle(
                              color:
                              Colors.grey.shade500,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                  ),
              ),
          );
        },
    );
  }
}