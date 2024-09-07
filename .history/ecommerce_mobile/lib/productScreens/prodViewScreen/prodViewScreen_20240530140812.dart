import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/configuration/wishlistConfig.dart';
import 'package:ecommerce_mobile/helper_components/bottomNavbar.dart';
import 'package:ecommerce_mobile/productScreens/prodViewScreen/carouselTopButtons.dart';
import 'package:ecommerce_mobile/productScreens/prodViewScreen/imageSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdViewScreen extends StatefulWidget {
  final dynamic product;
  const ProdViewScreen({super.key,this.product});

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
    // callCheckFav();
  }  

  bool isFav = false; // true, if product there in wishlist, otherwise false

  // then we will assign them values here
  @override
  void initState() {
    if(context.mounted){ // if everything is loaded
        // checkFav will check if the product is in the wishlist and then updates isFav variable accordingly using wishlistExistsCallback and wishlistAbsentCallback
        callCheckFav(); // this function simply calls checkFav function with appropriate parameters
        // callCheckFav is basically checkFav function, but shortened code
    }
    super.initState();
  }

  // this function simply calls checkFav function with appropriate parameters
  // this function was made to reduce code whenever we called checkFav function
  callCheckFav(){
      checkFav(context,
      product: widget.product, // widget.variable is used to get the variable defined in the original statefulClass
      wishlistExistsCallback: () => setState(()=>isFav=true), // will run if the product is present in wishlist
      wishlistAbsentCallback: () => setState(()=>isFav=false), // will run if the product is absent in wishlist
      ); 
  }

  @override
  Widget build(BuildContext context) {
  dynamic product = widget.product; // widget.variable is used to get the variable defined in the original statefulClass
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
                      child: CustomBackButton(), // this is from sliderTopButtons.dart
                    ),
            
                    Positioned(
                      top: 10,
                      right: 10,
                      child: FavButton( product:product, isFav:isFav, callback: callCheckFav) // this is from sliderTopButtons.dart
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product["title"], style: const TextStyle(fontSize:25,fontWeight:FontWeight.bold) ),
                            IconButton(
                              onPressed: (){},
                              padding: const EdgeInsets.all(4),
                              icon: const Icon(Icons.share_outlined)
                            )
                          ],
                        ),
                        const SizedBox(height: 10), // some spacing
                        
                        (product["discountPrice"] != 0 ? // if the product has a discount
                        Row(
                          children: [
                            Text(
                              "$currency.${product["price"]}   ",
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 127, 125, 125),
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                backgroundColor: Colors.red[50]
                                ),
                              ),
                            Text(
                              "$currency.${product["price"]-product["discountPrice"]}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 127, 125, 125),
                                ),
                              ),
                          ],
                        )
                        : Text(
                          "$currency ${product["price"]-product["discountPrice"]}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 127, 125, 125),
                            fontWeight: FontWeight.bold,
                            ),
                          )
                          ),
                      const SizedBox(height: 20), // some spacing
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(child: Text(
                            product["brand"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                            ))
                        ),
                      ),
                      const SizedBox(height: 40), // some spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ElevatedButton.icon(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  // minimumSize: const Size(200, 50),
                                  backgroundColor: const Color.fromARGB(255, 10, 114, 199),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  elevation: 4,
                                  shape: const BeveledRectangleBorder()
                                ),
                                icon: const Icon(Icons.shopping_cart_outlined),
                                iconAlignment: IconAlignment.start,
                                label: const Text("Add To Cart", style: TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // some spacing
                      const Text("Description", style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                      )),
                      const SizedBox(height: 7), // some spacing
                      Text(
                        product["description"],
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ]
                    ),
                ),
              ],
            ),
          ),

        //now the bottomNavBar
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }
}