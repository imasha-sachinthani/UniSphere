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

  final titleController = TextEditingController();
  final descriptionController =
  TextEditingController();
  final priceController = TextEditingController();
  final sellerController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      titleController.text =
          widget.product!.title;

      descriptionController.text =
          widget.product!.description;

      priceController.text =
          widget.product!.price.toString();

      sellerController.text =
          widget.product!.seller;

      imageController.text =
          widget.product!.imageUrl;
    }
  }

  Future<void> saveProduct() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final product = ProductModel(
      id: widget.product?.id ?? "",
      title: titleController.text.trim(),
      description:
      descriptionController.text.trim(),
      price: double.parse(
        priceController.text.trim(),
      ),
      seller: sellerController.text.trim(),
      imageUrl: imageController.text.trim(),
      createdAt:
      widget.product?.createdAt ??
          DateTime.now(),
    );

    if (widget.product == null) {
      await MarketplaceController.addProduct(
        product,
      );
    } else {
      await MarketplaceController
          .updateProduct(
        widget.product!.id,
        product,
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
        widget.product == null
            ? "Add Product"
            : "Edit Product",
      ),
      content: SizedBox(
        width: 430,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                TextFormField(
                  controller: titleController,
                  decoration:
                  const InputDecoration(
                    labelText:
                    "Product Name",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller:
                  descriptionController,
                  maxLines: 3,
                  decoration:
                  const InputDecoration(
                    labelText:
                    "Description",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller:
                  priceController,
                  keyboardType:
                  TextInputType.number,
                  decoration:
                  const InputDecoration(
                    labelText:
                    "Price",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return "Required";
                    }

                    if (double.tryParse(
                        value) ==
                        null) {
                      return "Invalid Price";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller:
                  sellerController,
                  decoration:
                  const InputDecoration(
                    labelText:
                    "Seller Name",
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller:
                  imageController,
                  decoration:
                  const InputDecoration(
                    labelText:
                    "Image URL",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: saveProduct,
          child: Text(
            widget.product == null
                ? "Save"
                : "Update",
          ),
        ),
      ],
    );
  }
}