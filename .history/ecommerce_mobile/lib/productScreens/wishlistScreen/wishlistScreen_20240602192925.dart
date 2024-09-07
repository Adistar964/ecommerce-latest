import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/helper_components/allProducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Your wishlist"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
      ),

      body: Column(
        children: [
          const SizedBox(height: 20), // some spacing
          AllProducts(products: context.watch<MyProvider>().wishlist),
        ],
      ),
    );
  }
}