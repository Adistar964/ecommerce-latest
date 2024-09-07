

import 'package:ecommerce_mobile/helper_components/bottomNavbar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}