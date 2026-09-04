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
  final TextEditingController searchController =
  TextEditingController();

  String searchText = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                16, 16, 16, 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon:
                const Icon(Icons.search),
                suffixIcon:
                searchText.isNotEmpty
                    ? IconButton(
                  icon: const Icon(
                      Icons.clear),
                  onPressed: () {
                    searchController
                        .clear();

                    setState(() {
                      searchText = "";
                    });
                  },
                )
                    : null,
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                      12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText =
                      value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<
                List<ProductModel>>(
              stream: MarketplaceController
                  .getProducts(),

              builder:
                  (context, snapshot) {
                if (snapshot
                    .connectionState ==
                    ConnectionState
                        .waiting) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error
                          .toString(),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                List<ProductModel>
                products =
                snapshot.data!;

                if (searchText
                    .isNotEmpty) {
                  products = products
                      .where((product) {
                    return product.title
                        .toLowerCase()
                        .contains(
                        searchText) ||
                        product.description
                            .toLowerCase()
                            .contains(
                            searchText) ||
                        product.seller
                            .toLowerCase()
                            .contains(
                            searchText);
                  }).toList();
                }

                if (products.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      children: [
                        Icon(
                          Icons
                              .shopping_bag_outlined,
                          size: 80,
                          color: Colors
                              .grey,
                        ),
                        SizedBox(
                            height: 20),
                        Text(
                          "No Products Found",
                          style:
                          TextStyle(
                            fontSize:
                            22,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child:
                  ListView.builder(
                    padding:
                    const EdgeInsets
                        .all(16),
                    itemCount:
                    products.length,
                    itemBuilder:
                        (context,
                        index) {
                      final product =
                      products[
                      index];

                      return ProductCard(
                        product:
                        product,

                        onEdit: () {
                          showDialog(
                            context:
                            context,
                            builder:
                                (_) =>
                                AddProductDialog(
                                  product:
                                  product,
                                ),
                          );
                        },

                        onDelete:
                            () async {
                          final confirm =
                          await showDialog<
                              bool>(
                            context:
                            context,
                            builder:
                                (_) =>
                                AlertDialog(
                                  title:
                                  const Text(
                                      "Delete Product"),
                                  content:
                                  const Text(
                                      "Are you sure you want to delete this product?"),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                            context,
                                            false);
                                      },
                                      child:
                                      const Text(
                                          "Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                            context,
                                            true);
                                      },
                                      child:
                                      const Text(
                                          "Delete"),
                                    ),
                                  ],
                                ),
                          );

                          if (confirm ==
                              true) {
                            await MarketplaceController
                                .deleteProduct(
                              product.id,
                            );
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Add"),
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