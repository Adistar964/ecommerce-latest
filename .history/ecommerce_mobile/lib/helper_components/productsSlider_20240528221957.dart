
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/helper_components/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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

  @override
  void initState() {

    if(context.mounted){ // first let everything get loaded
      assignProductCartQuantity(); // this will check if the product is in the cart
    }

    super.initState(); // parent initState must always run atlast!
  }

  assignProductCartQuantity(){
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
      productCartQuantity = 0;
    }
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
                        onPressed: addToCart,
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
                          onPressed: subtractQuantity,
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
                          onPressed: addQuantity,
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
            child: IconButton(
              onPressed: (){},
              // color: Colors.grey[600],
              style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[100],
              ),
              icon: const Icon(Icons.favorite_outline_rounded, color:Colors.black),
              padding: const EdgeInsets.all(10),
            ),
          )
          ]
        ),
      ),
    );
  }


    // first time adding smth to cart
    // this will add that item to user's cart
    // and once added, now Quantity-functions below will take care of rest
  addToCart() async {
    print("here");
    // start doing our stuff...

    dynamic newCart = [ ...context.read<MyProvider>().cart ]; // our current cart (we will make changes to it)
    newCart.add({ // adding this product to our cart
        "product_id":widget.product["_id"],
        "quantity":1,
        "thumbnail":widget.product["thumbnail"],
        "price":widget.product["price"],
        "product_name":widget.product["title"],
        "discountPrice":widget.product["discountPrice"],
        "maxQuantityForAUser":widget.product["maxQuantityForAUser"]
    });
    // then assigning this newCart in our backend

    Map body = {
      "uid":FirebaseAuth.instance.currentUser?.uid,
      "update_query": {"\$set": {"cart_items":newCart}},
       // "/$" will evaluate to $ ( $ cannot simply be used in a string, otherwise it will treat set as a variable)
    };
    Uri url = Uri.parse("$backend_url/updateUserDoc/");

    try {
      Response response = await post(url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(body)
      );
      dynamic data = jsonDecode(response.body); // the response back from backend is not needed
      context.read<MyProvider>().setCart(newCart);
      assignProductCartQuantity(); // to change the quantity of the product if changed
    }catch(e){
        print(e);
    }
  }

  // quantity functions ////////////////////////////////////

  
  subtractQuantity() async {
    try{
      dynamic newCart = [ ...context.read<MyProvider>().cart ]; // our current cart (we will make changes to it)
      for (var item in newCart){
        if(item["product_id"] == widget.product["_id"]){ // first find the item in the cart

            if(item["quantity"] == 1){ // if quantity is 1, and hence user clicked "-" button, we will remove the product from the cart itself
              newCart.removeWhere((item) => item["product_id"]==widget.product["_id"]); // remove the item from the cart which has the product_id as specified
              // widget.product refers to the product variable we created in the main StatefulWidget-class
            }else{
              item["quantity"] --; // subtract one from the item's quantity
            }

            // then we send this newly modified cart to our backend (backend processing)
            Map body = {
              "uid":FirebaseAuth.instance.currentUser?.uid, // ? is null-safety (look thru home.dart)
              "update_query": {"\$set":{"cart_items":newCart}}
            };
            Uri url = Uri.parse("$backend_url/updateUserDoc/");
            Response response = await post(
              url,
              headers: {"Content-Type":"application/json"},
              body: jsonEncode(body)
            );
            dynamic data = jsonDecode(response.body); // the response back from backend is not needed
            context.read<MyProvider>().setCart(newCart);
            assignProductCartQuantity(); // to change the quantity of the product if changed
            
            break; // break free from the loop as we r done
        }
      }
    }catch(e){
      print(e);
    }
  }

  addQuantity() async {
    try{
      dynamic newCart = [ ...context.read<MyProvider>().cart ];
      for (var item in newCart){
        if(item["product_id"] == widget.product["_id"]){ // first find the item in the cart

          if(item["quantity"] == item["maxQuantityForAUser"]){ // if quantity reached its maxLimit, and hence user clicked "+" button, we will show an alert
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar( content: Text("The quantity has reached its max limit") )
              );
              // we wont be doing any processing with the backend here, as the cart hasnt changed, but we only sent the user a warning alert
          }else{
            item["quantity"] ++; // add one from the item's quantity
            // then we send this newly modified cart to our backend (backend-processing)
            Map body = {
              "uid":FirebaseAuth.instance.currentUser?.uid, // ? is null-safety (look thru home.dart)
              "update_query": {"\$set":{"cart_items":newCart}}
            };
            Uri url = Uri.parse("$backend_url/updateUserDoc/");
            Response response = await post(
              url,
              headers: {"Content-Type":"application/json"},
              body: jsonEncode(body)
            );
            dynamic data = jsonDecode(response.body); // the response back from backend is not needed
            context.read<MyProvider>().setCart(newCart);
            assignProductCartQuantity(); // to change the quantity of the product if changed
          }
          break; // break free from the loop as we r done
        }
      }
    }catch(e){
      print(e);
    }
  }
}