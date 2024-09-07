import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  SearchInput({
    super.key,
  });

  final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: searchFieldController,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          hintText: "What are you looking for?",
          border: OutlineInputBorder( borderRadius: BorderRadius.circular(15) ),
        ),
      ),
    );
  }
}