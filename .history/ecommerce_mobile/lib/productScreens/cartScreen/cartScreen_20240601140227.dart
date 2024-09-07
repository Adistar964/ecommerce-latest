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
        backgroundColor: Colors.blueGrey[100],
      ),
      body : (emptyCart())
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
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(3)
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
}