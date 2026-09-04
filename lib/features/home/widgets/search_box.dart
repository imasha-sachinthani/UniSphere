import 'package:flutter/material.dart';

import '../../search/screens/search_screen.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SearchScreen(),
          ),
        );
      },
      child: IgnorePointer(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search...",

            prefixIcon: const Icon(
              Icons.search,
            ),

            filled: true,
            fillColor: Colors.grey.shade100,

            contentPadding:
            const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),

            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}