import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../core/services/storage_service.dart';
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

  File? selectedImage;
  bool isUploading = false;

  String existingImageUrl = "";

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

      existingImageUrl =
          widget.product!.imageUrl;
    }
  }

  Future<void> pickImage() async {
    final image =
    await ImagePickerService.pickImage();

    if (image == null) return;

    setState(() {
      selectedImage = image;
    });
  }

  Future<void> saveProduct() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isUploading = true;
    });

    String imageUrl = existingImageUrl;

    if (selectedImage != null) {
      imageUrl =
      await StorageService.uploadImage(
        selectedImage!,
        "marketplace",
      );
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
      imageUrl: imageUrl,
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

    setState(() {
      isUploading = false;
    });
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
                  controller:
                  titleController,
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
                    labelText: "Price",
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

                const SizedBox(height: 20),

                if (selectedImage != null)
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                        12),
                    child: Image.file(
                      selectedImage!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else if (existingImageUrl
                    .isNotEmpty)
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                        12),
                    child: Image.network(
                      existingImageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                const SizedBox(height: 15),

                OutlinedButton.icon(
                  onPressed: pickImage,
                  icon:
                  const Icon(Icons.photo),
                  label:
                  const Text("Choose Image"),
                ),

                if (isUploading)
                  const Padding(
                    padding:
                    EdgeInsets.only(
                        top: 15),
                    child:
                    CircularProgressIndicator(),
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
          onPressed:
          isUploading ? null : saveProduct,
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