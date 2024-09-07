import 'package:ecommerce_mobile/productScreens/prodViewScreen/customBackButton.dart';
import 'package:ecommerce_mobile/productScreens/prodViewScreen/imageSlider.dart';
import 'package:flutter/material.dart';

class ProdViewScreen extends StatefulWidget {
  const ProdViewScreen({super.key});

  @override
  State<ProdViewScreen> createState() => _ProdViewScreenState();
}

class _ProdViewScreenState extends State<ProdViewScreen> {

  int activeCarouselIndex = 0; // initally carousel's active slide will be the first one
  // above is to keep track of active index of the carousel so that the indicator can display it accurately

  // once the carousel changes slides and hence also active index, we will change our activeCarouselIndex using setState
  setActiveCarouselIndex(index){
    setState(() {
      activeCarouselIndex = index;
    });
  }  

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)?.settings.arguments; // to access the arguments passed to this screen via the .pushNamed method
    dynamic product = args["product"]; // getting product argument from the arguments passed onto this screen
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children:[
              ProductImageSlider( images:product["images"], changeActiveIdxFunction:setActiveCarouselIndex),
              const Positioned(
                top:10,
                left: 10,
                child: CustomBackButton(),
              ),
              Positioned(
                bottom: 10,
                child: Align(
                  alignment: Alignment.center,
                  child: CarouselIndicators(
                    numberOfIndicators: product["images"].length,
                    activeCarouselIndex: activeCarouselIndex,
                  ),
                ),
              )
            ]
          ),
      ),
    );
  }
}