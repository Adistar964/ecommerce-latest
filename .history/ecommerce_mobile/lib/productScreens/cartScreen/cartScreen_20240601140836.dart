// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Your Cart"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(179, 207, 216, 220),
      ),
      body : (Provider.of<MyProvider>(context).cart.length == 0 ? 
              emptyCart() // show this emptyCart widget if cart is empty
              : CartScreenBody()  // otherwise show this widget
              )
    );
  }

  Widget emptyCart(){
    return Center(
      child: Column(
        children : [
          const SizedBox(height: 100), // some spacing
          const Icon(
            Icons.shopping_bag,
            size:200,
            opticalSize: 100,
            color:Color.fromARGB(255, 209, 46, 78)
            ),
          const SizedBox(height: 40), // some spacing
          const Text(
            "There is nothing in your cart!",
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 168, 161, 161)
            ),
          ),
          const SizedBox(height: 40), // some spacing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(203, 129, 165, 184),
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Text(
                "Click the 'Add' button on the products to add them in the cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                // color: Color.fromARGB(255, 168, 161, 161)
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget CartScreenBody(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Items:"),
        const SizedBox(height: 40), // some spacing
      ]
    );
  }
}