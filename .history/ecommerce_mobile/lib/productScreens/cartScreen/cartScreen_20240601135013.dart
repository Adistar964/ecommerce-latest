import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body : (emptyCart())
    );
  }

  Widget emptyCart(){
    return const Column(
      children : [
        Icon(Icons.shopping_basket_outlined,size:400,color:Color.fromARGB(67, 130, 125, 125)),
        SizedBox(height: 40),

      ]
    );
  }
}