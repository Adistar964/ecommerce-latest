
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_mobile/configuration/cartConfig.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/configuration/wishlistConfig.dart';
import 'package:ecommerce_mobile/helper_components/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ProductSlider extends StatelessWidget {
  final dynamic products; // list of products to add in the carousel-slider
  const ProductSlider({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.5,
          // enlargeCenterPage: true,
          enableInfiniteScroll: false,
          height: 420,
          initialPage: 1,
          // autoPlay: true,
          // autoPlayAnimationDuration: const Duration(seconds: 20),
        ),
        items: products.map<Widget>((product) => 
            ProductCard(product: product)
        ).toList()
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final dynamic product; // product param will have all info like title,price,etc..
  const ProductCard({super.key, this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int productCartQuantity = 0; // we will first assume the product is not there in cart
  dynamic isFav = false; // we will first assume the product is not in the wishlist

  @override
  void initState() {

    if(context.mounted){ // first let everything get loaded
      // this will check if the product is in the cart and assigns it a proper quantity if it exists, otherwise assigns product a quantity of 0
      assignProductCartQuantity();
      // this will check if the product is in the wishlist and then updates isFav variable accordingly
      checkFav();
    }

    super.initState(); // parent initState must always run atlast!
  }

  // this will check if the product is in the cart and assign it a proper quantity if it exists, otherwise assigns product a quantity of 0
  assignProductCartQuantity(){
      if(Provider.of<MyProvider>(context,listen:false).cart != null){ // first check if it is loaded from backend
            String productId = widget.product["_id"]; // widget.variable is used to get the variable defined in the original statefulClass
            dynamic cart = context.read<MyProvider>().cart;
            dynamic exists = false; // we will check if the item exists in the cart, if not then we will set the item's quantity to 0
            
            for (var item in cart){
              if (item["product_id"] == productId){ // first check if the product exists in the cart
                // if it exists, update the productCartQuantity variable created above
                exists = true;
                setState(() {
                  productCartQuantity = item["quantity"];
                });
                break; // then break free from the loop once we found the product in the cart
              }
            }

            if(!exists){ // if not there in cart, then set quantity to 0
              setState((){
                productCartQuantity = 0;
              });
            }
      }
  }

// this will check if the product is in the wishlist and then updates isFav variable accordingly
  checkFav(){
      // if(Provider.of<MyProvider>(context,listen:false).wishlist != null){ // first check if it is loaded from backend
            String productId = widget.product["_id"]; // widget.variable is used to get the variable defined in the original statefulClass
            dynamic wishlist = context.read<MyProvider>().wishlist;
            dynamic exists = false; // we will check if the item exists in the wishlist, if not then we will set the item's quantity to 0
            
            for (var item in wishlist){
              if (item["product_id"] == productId){ // checking if there in wishlist
                exists = true;
                print("now exists");
                break; // then break free from the loop once we found the product in the wishlist
              }
            }

            if(exists){  // first check if the product exists in the wishlist
              // if it exists, update the productwishlistQuantity variable created above
              setState(() {
                isFav = true;
              });

            }else{
              setState(() {
                isFav = false;
              });

            }
      // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Card.outlined(
              color: Colors.grey[100],
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // card-header
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.network(widget.product["thumbnail"], fit: BoxFit.fill),
                      ),

                      // card-body
                      Column(
                        children: [
                      const SizedBox(height: 10), // leaving some space
                      SizedBox(
                        height: 20, // for the purpose of giving uniform height to title-spaces regardless of how long the titles are
                        child: Text(
                          widget.product["title"], 
                          style: const TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 17)
                        ),
                      ),
                      const SizedBox(height: 16), // leaving some space
                      ( // only show discounted price if there was a dicountPrice assigned to the product
                      widget.product["disocuntPrice"] != 0 ?
                      Text(
                        "$currency ${widget.product["price"]}", // price is actual price minus any discount in it
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          decoration: TextDecoration.lineThrough
                        ), 
                      )
                      : const Text("")),
                      const SizedBox(height: 6), // leaving some space
                      Text(
                        "$currency ${widget.product["price"] - widget.product["discountPrice"]}", // price is actual price minus any discount in it
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ), 
                      ),
                      const SizedBox(height: 10), // leaving some space
                        ],
                      ),

                      // card-footer
                      (productCartQuantity == 0 ? // if not there in cart 
                      MaterialButton(
                        // onPressed: ()=>addToCart(context, widget.product, assignProductCartQuantity),
                        onPressed: () => print(isFav),
                        // widget.product refers to the product variable we created in the main StatefulWidget-class
                        padding: const EdgeInsets.all(8),
                        color : Colors.lightBlue,
                        textColor: Colors.white,
                        minWidth: double.maxFinite,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                        child: const Text("Add", style: TextStyle(fontSize:18)),
                      )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: ()=>subtractQuantity(context, widget.product, assignProductCartQuantity),
                          padding: const EdgeInsets.all(8),
                          color : Colors.lightBlue,
                          textColor: Colors.white,
                          // shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                          child: const Icon(Icons.remove, size:25 ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right:4, left:4, top:6, bottom:4),
                          decoration: BoxDecoration(
                            border: Border.all( color: Colors.grey )
                          ),
                          child: Center(
                            child: Text(
                              "$productCartQuantity",
                              style: const TextStyle(
                                fontSize: 20, 
                                color: Colors.black,
                                backgroundColor: Colors.white,
                                ),
                              ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: ()=>addQuantity(context, widget.product, assignProductCartQuantity),
                          padding: const EdgeInsets.all(8),
                          color : Colors.lightBlue,
                          textColor: Colors.white,
                          // shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                          child: const Icon(Icons.add, size:25 ),
                        ),
                      )
                      ],
                    )
                    )
                    ],
                ),
              ),
            ),

          // this second widget(iconButton) will be stacked on top of the previous first widget(card.outlined)
          Positioned( // Positioned is for giving any position to elements inside it
            top: 0,
            right: 0,
            child: LikeButton( // from like_button package => it gives cool like animation
              isLiked: isFav, // show liked-color(pink) if it is in favourites/wishlist
              // color: Colors.grey[600],
              // style: IconButton.styleFrom(
              //     backgroundColor: Colors.grey[100],
              // ),
              // icon: Icon(Icons.favorite_outline_rounded, color: isFav==true ? Colors.red :Colors.black),
              // padding: const EdgeInsets.all(10),
              likeBuilder: (isLiked) => 
              IconButton(
                iconSize: 30,
                style: IconButton.styleFrom(
                  backgroundColor: Color.fromARGB(112, 100, 95, 95),
                  // side: const BorderSide(),
                  shape: const BeveledRectangleBorder(),
                  padding: const EdgeInsets.all(0)
                ),
                onPressed: ()=>toggleFav(context, widget.product, checkFav),
                icon: Icon(Icons.favorite_outline_rounded,color: isLiked==true ? Colors.red :Colors.grey)
              )
            ),
          )
          ]
        ),
      ),
    );
  }
}