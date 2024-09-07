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
    return const Center(
      child: Column(
        children : [
          SizedBox(height: 40), // some spacing
          Icon(
            Icons.shopping_bag,
            size:200,
            opticalSize: 100,
            color:Color.fromARGB(255, 209, 46, 78)
            ),
          SizedBox(height: 40), // some spacing
          Text(
            "There is nothing in your cart!",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            ),
          )
        ]
      ),
    );
  }
}