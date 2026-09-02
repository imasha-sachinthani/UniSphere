import 'package:flutter/material.dart';

import '../controllers/marketplace_controller.dart';
import '../models/product_model.dart';
import '../widgets/add_product_dialog.dart';
import '../widgets/product_card.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() =>
      _MarketplaceScreenState();
}

class _MarketplaceScreenState
    extends State<MarketplaceScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Marketplace"),
        centerTitle: true,
      ),

      body: StreamBuilder<List<ProductModel>>(

        stream:
        MarketplaceController.getProducts(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    "No Products Available",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Tap + to add your first product.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          final products = snapshot.data!;

          return ListView.builder(

            padding:
            const EdgeInsets.all(16),

            itemCount: products.length,

            itemBuilder: (context, index) {

              final product = products[index];

              return ProductCard(

                product: product,

                onEdit: () {

                  showDialog(
                    context: context,
                    builder: (_) =>
                        AddProductDialog(
                          product: product,
                        ),
                  );
                },

                onDelete: () async {

                  final confirm =
                  await showDialog<bool>(

                    context: context,

                    builder: (_) => AlertDialog(

                      title:
                      const Text("Delete"),

                      content: const Text(
                        "Delete this product?",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                                context,
                                false);
                          },
                          child:
                          const Text("Cancel"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context,
                                true);
                          },
                          child:
                          const Text("Delete"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {

                    await MarketplaceController
                        .deleteProduct(
                      product.id,
                    );
                  }
                },
              );
            },
          );
        },
      ),

      floatingActionButton:
      FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {

          showDialog(

            context: context,

            builder: (_) =>
            const AddProductDialog(),
          );
        },
      ),
    );
  }
}