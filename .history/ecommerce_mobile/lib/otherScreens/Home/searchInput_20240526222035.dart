import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    required this.searchFieldController,
  });

  final TextEditingController searchFieldController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: searchFieldController,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          hintText: "What are you looking for?",
          border: OutlineInputBorder( borderRadius: BorderRadius.circular(8) ),
        ),
      ),
    );
  }
}