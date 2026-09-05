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

  final TextEditingController
  searchController =
  TextEditingController();

  String searchText = "";

  String selectedCategory = "All";

  final List<String> categories = [

    "All",

    "Books",

    "Electronics",

    "Furniture",

    "Clothing",

    "Accessories",

    "Other",
  ];

  @override
  void dispose() {

    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          title: const Text(
            "Student Marketplace",
          ),

          centerTitle: true,

        ),

        body: Column(

            children: [

        Padding(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

          TextField(

          controller:
          searchController,

          decoration:
          InputDecoration(

            hintText:
            "Search products",

            prefixIcon:
            const Icon(
              Icons.search,
            ),

            suffixIcon:
            searchText
                .isNotEmpty

                ? IconButton(

              onPressed: () {

                searchController
                    .clear();

                setState(() {

                  searchText =
                  "";

                });
              },

              icon:
              const Icon(
                Icons.clear,
              ),
            )

                : null,

            border:
            OutlineInputBorder(

              borderRadius:
              BorderRadius
                  .circular(
                14,
              ),
            ),
          ),

          onChanged: (value) {

            setState(() {

              searchText =
                  value
                      .toLowerCase();

            });

          },
        ),

        const SizedBox(
          height: 15,
        ),

        SizedBox(

            height: 42,

            child: ListView.builder(

                scrollDirection:
                Axis.horizontal,

                itemCount:
                categories.length,

                itemBuilder:
                    (context, index) {

                  final category =
                  categories[index];                      return Padding(
                    padding:
                    const EdgeInsets.only(
                      right: 10,
                    ),

                    child: ChoiceChip(
                      label: Text(category),

                      selected:
                      selectedCategory ==
                          category,

                      onSelected: (_) {

                        setState(() {

                          selectedCategory =
                              category;

                        });

                      },
                    ),
                  );
                    },
            ),
        ),
          ],
        ),
    ),

    Expanded(

    child: StreamBuilder<
    List<ProductModel>>(

    stream:
    MarketplaceController
        .getProducts(),

    builder:
    (context, snapshot) {

    if (snapshot.connectionState ==
    ConnectionState.waiting) {

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

    if (selectedCategory !=
    "All") {

    products = products
        .where(
    (product) =>
    product.category ==
    selectedCategory,
    )
        .toList();
    }

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

    product.sellerName
        .toLowerCase()
        .contains(
    searchText);

    }).toList();
    }

    if (products.isEmpty) {

    return Center(

    child: Column(

    mainAxisAlignment:
    MainAxisAlignment
        .center,

    children: [

    Icon(
    Icons
        .storefront_outlined,
    size: 90,
    color: Colors
        .grey
        .shade400,
    ),

    const SizedBox(
    height: 20,
    ),

    const Text(
    "No Products Found",

    style: TextStyle(
    fontSize: 22,
    fontWeight:
    FontWeight.bold,
    ),
    ),

    const SizedBox(
    height: 8,
    ),

    Text(
    "Tap the Add Product button to publish your first item.",

    textAlign:
    TextAlign.center,

    style: TextStyle(
    color: Colors
        .grey
        .shade600,
    ),
    ),
    ],
    ),
    );
    }                return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },

      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          90,
        ),

        itemCount: products.length,

        itemBuilder:
            (context, index) {

          final product =
          products[index];

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

                builder: (_) =>
                    AlertDialog(

                      title: const Text(
                        "Delete Product",
                      ),

                      content:
                      const Text(
                        "Are you sure you want to delete this product?",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {

                            Navigator.pop(
                              context,
                              false,
                            );

                          },

                          child:
                          const Text(
                            "Cancel",
                          ),
                        ),

                        ElevatedButton(

                          style:
                          ElevatedButton
                              .styleFrom(

                            backgroundColor:
                            Colors.red,

                            foregroundColor:
                            Colors.white,
                          ),

                          onPressed: () {

                            Navigator.pop(
                              context,
                              true,
                            );

                          },

                          child:
                          const Text(
                            "Delete",
                          ),
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

      floatingActionButtonLocation:
      FloatingActionButtonLocation
          .centerFloat,

      floatingActionButton:
      FloatingActionButton.extended(

        icon: const Icon(
          Icons.add,
        ),

        label: const Text(
          "Add Product",
        ),

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