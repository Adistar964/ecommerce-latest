import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your wishlist"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
      ),

      body: const Placeholder(),
    );
  }
}