
import 'package:flutter/material.dart';

class ProdViewScreen extends StatefulWidget {
  final dynamic product;
  const ProdViewScreen({super.key,this.product});

  @override
  State<ProdViewScreen> createState() => _ProdViewScreenState();
}

class _ProdViewScreenState extends State<ProdViewScreen> {


  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)?.settings.arguments; // to access the arguments passed to this screen via the .pushNamed method
    dynamic product = args["product"]; // getting product argument from the arguments passed onto this screen
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Text(product.title)
          ),
      ),
    );
  }
}