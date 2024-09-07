import 'package:ecommerce_mobile/configuration/constants.dart';
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
          body: SingleChildScrollView(
            child: Column(
              children: [

                // first the image carousel
                Stack(
                  children:[
                   
                    ProductImageSlider( images:product["images"], changeActiveIdxFunction:setActiveCarouselIndex),
                    
                    const Positioned(
                      top:10,
                      left: 10,
                      child: CustomBackButton(),
                    ),
                  
                    Positioned(
                      bottom: 10,
                      left: 0, // left:0 and right:0 makes it take the whole width
                      right: 0,
                      child: Align(
                        alignment: Alignment.center, // then we align this in center in that width
                        child: CarouselIndicators(
                          numberOfIndicators: product["images"].length,
                          activeCarouselIndex: activeCarouselIndex,
                        ),
                      ),
                    )
                  
                  ]
                ),

                // then the rest.. (product title,etc...)
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top:20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        Text(product["title"], style: const TextStyle(fontSize:22)),
                        const SizedBox(height: 10), // some spacing
                        
                        Row(
                          children: [
                            (product["discountPrice"]!=0 ?  // if there is discount, then show it
                            Text(
                              "$currency ${product["price"]}    ",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 127, 125, 125),
                                decoration: TextDecoration.lineThrough
                                ),
                              )
                            : const Placeholder() ), // if u want nothing, then place the placeholder
                            Text(
                              "$currency ${product["price"]-product["discountPrice"]}",
                              style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 127, 125, 125)),
                              ),
                          ],
                        )
                    ]
                    ),
                )
              ],
            ),
          ),
      ),
    );
  }
}