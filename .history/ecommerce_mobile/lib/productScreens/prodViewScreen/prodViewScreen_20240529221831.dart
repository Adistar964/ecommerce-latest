import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
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
  }  

  bool isFav = false; // true, if product there in wishlist, otherwise false

  // then we will assign them values here
  @override
  void initState() {
    if(context.mounted){ // if everything is loaded
        // args = ModalRoute.of(context)?.settings.arguments; // to access the arguments passed to this screen via the .pushNamed method
        // product = args["product"]; // getting product argument from the arguments passed onto this screen
        // checkFav(); // this will check if the product is in the wishlist and then updates isFav variable accordingly
    }
    super.initState();
  }

  // this will check if the product is in the wishlist and then updates isFav variable accordingly
  checkFav(){
      if(Provider.of<MyProvider>(context,listen:false).wishlist != null){ // first check if it is loaded from backend
            String productId = widget.product["_id"]; // widget.variable is used to get the variable defined in the original statefulClass
            dynamic wishlist = context.read<MyProvider>().wishlist;
            dynamic exists = false; // we will check if the item exists in the wishlist, if not then we will set the item's quantity to 0
            
            for (var item in wishlist){
              if (item["product_id"] == productId){ // checking if there in wishlist
                exists = true;
                break; // then break free from the loop once we found the product in the wishlist
              }
            }

            if(exists==true){  // first check if the product exists in the wishlist
              // if it exists, update the productwishlistQuantity variable created above
              setState(() {
                isFav = true;
              });

            }else{
              setState(() {
                isFav = false;
              });

            }
      }
  }

  @override
  Widget build(BuildContext context) {
  dynamic product = widget.product;
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

                    // const Positioned(
                    //   top: 10,
                    //   right: 10,
                    //   child: FavButton() // this is from sliderTopButtons.dart
                    // ),
                  
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
                        Text(product["title"], style: const TextStyle(fontSize:25,fontWeight:FontWeight.bold) ),
                        const SizedBox(height: 10), // some spacing
                        
                        (product["discountPrice"] != 0 ? // if the product has a discount
                        Row(
                          children: [
                            Text(
                              "$currency ${product["price"]}    ",
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 127, 125, 125),
                                decoration: TextDecoration.lineThrough,
                                backgroundColor: Colors.orange[100]
                                ),
                              ),
                            Text(
                              "$currency ${product["price"]-product["discountPrice"]}",
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 127, 125, 125),
                                backgroundColor: isFav ? Colors.pink: Colors.lightGreen[100]
                                ),
                              ),
                          ],
                        )
                        : Text(
                          "$currency ${product["price"]-product["discountPrice"]}",
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 127, 125, 125),
                            backgroundColor: Colors.blueGrey[100]
                            ),
                          )
                          ),
                      const SizedBox(height: 10), // some spacing
                      Text(
                        product["description"],
                        style: const TextStyle(
                          fontSize: 19.7
                        ),
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