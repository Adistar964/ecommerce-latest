import 'package:ecommerce_mobile/productScreens/prodViewScreen/imageSlider.dart';
import 'package:flutter/material.dart';

class ProdViewScreen extends StatefulWidget {
  const ProdViewScreen({super.key});

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
          body: Stack(
            children:[
              ProductImageSlider(images:product["images"])
            ]
          ),
      ),
    );
  }
}