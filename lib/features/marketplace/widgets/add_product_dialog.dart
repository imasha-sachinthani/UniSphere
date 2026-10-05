import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/marketplace_controller.dart';
import '../models/product_model.dart';

class AddProductDialog extends StatefulWidget {
  final ProductModel? product;

  const AddProductDialog({
    super.key,
    this.product,
  });

  @override
  State<AddProductDialog> createState() =>
      _AddProductDialogState();
}

class _AddProductDialogState
    extends State<AddProductDialog> {

  final formKey = GlobalKey<FormState>();

  final titleController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final priceController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  bool isSaving = false;

  String sellerName = "";
  String sellerEmail = "";
  String uid = "";

  String? selectedCategory;
  String? selectedCondition;

  final List<String> categories = [
    "Books",
    "Electronics",
    "Furniture",
    "Clothing",
    "Accessories",
    "Other",
  ];

  final List<String> conditions = [
    "New",
    "Used",
  ];

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      titleController.text =
          widget.product!.title;

      descriptionController.text =
          widget.product!.description;

      priceController.text =
          widget.product!.price
              .toString();

      phoneController.text =
          widget.product!.phone;

      selectedCategory =
          widget.product!.category;

      selectedCondition =
          widget.product!.condition;
    }

    loadCurrentUser();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> loadCurrentUser() async {
    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    uid = user.uid;

    final doc =
    await FirebaseFirestore.instance
        .collection("profiles")
        .doc(uid)
        .get();

    if (!doc.exists) return;

    final data = doc.data()!;

    sellerName =
        data["fullName"] ?? "";

    sellerEmail =
        data["email"] ?? "";

    if (widget.product == null) {
      phoneController.text =
          data["phone"] ?? "";
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> saveProduct() async {
    if (!formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {
      isSaving = true;
    });

    final product = ProductModel(
      id: widget.product?.id ?? "",

      uid: uid,

      title: titleController.text
          .trim(),

      description:
      descriptionController.text
          .trim(),

      price: double.parse(
        priceController.text.trim(),
      ),
      category:
      selectedCategory ??
          "Other",

      condition:
      selectedCondition ??
          "Used",

      sellerName: sellerName,

      sellerEmail: sellerEmail,

      phone: phoneController.text
          .trim(),

      imageUrl:
      widget.product?.imageUrl ??
          "",

      isSold:
      widget.product?.isSold ??
          false,

      createdAt:
      widget.product?.createdAt ??
          DateTime.now(),
    );

    if (widget.product == null) {

      await MarketplaceController
          .addProduct(product);

    } else {

      await MarketplaceController
          .updateProduct(
        widget.product!.id,
        product,
      );
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: isDark
          ? const Color(0xFF1E1E1E)
          : Colors.grey.shade100,

      labelStyle: TextStyle(
        color: isDark
            ? Colors.grey.shade300
            : Colors.grey.shade700,
      ),

      hintStyle: TextStyle(
        color: isDark
            ? Colors.grey.shade500
            : Colors.grey.shade600,
      ),

      prefixIconColor: isDark
          ? Colors.grey.shade400
          : Colors.grey.shade700,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark
              ? Colors.grey.shade700
              : Colors.grey.shade300,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return AlertDialog(
      backgroundColor: isDark
          ? const Color(0xFF2A2A2A)
          : Colors.white,
      title: Text(
        widget.product == null
            ? "Add Product"
            : "Edit Product",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
        ),
      ),

        content: SizedBox(
            width: 420,

            child: Form(
                key: formKey,

                child: SingleChildScrollView(
                    child: Column(
                        children: [                TextFormField(
                      controller: titleController,
                          decoration: inputDecoration.copyWith(
                            labelText: "Product Name",
                            prefixIcon: const Icon(Icons.shopping_bag),
                          ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return "Product name is required";
                        }
                        return null;
                      },
                    ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller:
                    descriptionController,
                    maxLines: 3,
                    decoration: inputDecoration.copyWith(
                      labelText: "Description",
                      prefixIcon: const Icon(Icons.description),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller:
                    priceController,
                    keyboardType:
                    TextInputType.number,
                    decoration: inputDecoration.copyWith(
                      labelText: "Price (LKR)",
                      prefixIcon: const Icon(Icons.currency_rupee),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return "Price is required";
                      }

                      if (double.tryParse(
                          value) ==
                          null) {
                        return "Enter a valid price";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<
                      String>(
                    value:
                    selectedCategory,
                    decoration: inputDecoration.copyWith(
                      labelText: "Category",
                      prefixIcon: const Icon(Icons.category),
                    ),
                    items: categories
                        .map(
                          (category) =>
                          DropdownMenuItem(
                            value: category,
                            child:
                            Text(category),
                          ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory =
                            value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),                DropdownButtonFormField<String>(
                  value: selectedCondition,
                            decoration: inputDecoration.copyWith(
                              labelText: "Condition",
                              prefixIcon: const Icon(Icons.verified),
                            ),
                  items: conditions
                      .map(
                        (condition) =>
                        DropdownMenuItem(
                          value: condition,
                          child:
                          Text(condition),
                        ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCondition =
                          value;
                    });
                  },
                ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller:
                    phoneController,
                    keyboardType:
                    TextInputType.phone,
                    decoration: inputDecoration.copyWith(
                      labelText: "Phone Number",
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length < 10) {
                        return "Invalid phone number";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.all(
                      16,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E1E1E)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [

                        const Text(
                          "Seller Information",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [

                            CircleAvatar(
                              backgroundColor: isDark
                                  ? Colors.blue.withValues(alpha: 0.20)
                                  : Colors.blue.shade100,
                              child: const Icon(
                                Icons.person,
                                color:
                                Colors.blue,
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [

                                  Text(
                                    sellerName
                                        .isEmpty
                                        ? "Loading..."
                                        : sellerName,
                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 4,
                                  ),

                                  Text(
                                    sellerEmail,
                                    style:
                                    TextStyle(
                                      color: isDark
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                          SwitchListTile(
                            value: widget.product?.isSold ?? false,
                            onChanged: null,

                            inactiveThumbColor:
                            isDark ? Colors.grey.shade600 : null,

                            inactiveTrackColor:
                            isDark ? Colors.grey.shade800 : null,
                    title: const Text(
                      "Sold",
                    ),
                    subtitle: const Text(
                      "This option will be available after publishing.",
                    ),
                  ),
                        ],
                    ),
                ),
            ),
        ),

      actions: [

        TextButton(
          onPressed: isSaving
              ? null
              : () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: isDark
                  ? Colors.grey.shade300
                  : Colors.grey.shade700,
            ),
          ),
        ),

        ElevatedButton.icon(
          onPressed: isSaving
              ? null
              : saveProduct,

          icon: isSaving
              ? const SizedBox(
            width: 18,
            height: 18,
            child:
            CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Icon(
            Icons.save,
          ),

          label: Text(
            isSaving
                ? "Saving..."
                : widget.product == null
                ? "Add Product"
                : "Update Product",
          ),

          style: ElevatedButton.styleFrom(
            backgroundColor:
            Colors.blue,
            foregroundColor:
            Colors.white,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}