
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
    print(products);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.5,
          // enlargeCenterPage: true,
          enableInfiniteScroll: false,
          height: 420,
          initialPage: 1,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 20),
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

    assignProductCartQuantity(); // this will check if the product is in the cart

    super.initState(); // parent initState must always run atlast!
  }

  assignProductCartQuantity(){
    String productId = widget.product["_id"]; // widget.variable is used to get the variable defined in the original statefulClass
    dynamic cart = context.read<MyProvider>().cart;
    for (var item in cart){
      if (item["_id"] == productId){ // first check if the product exists in the cart
        // if it exists, update the productCartQuantity variable created above
        setState(() {
          productCartQuantity = item["quantity"];
        });
        break; // then break free from the loop once we found the product in the cart
      }
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
                        onPressed: (){},
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
                          onPressed: (){},
                          padding: const EdgeInsets.all(8),
                          color : Colors.lightBlue,
                          textColor: Colors.white,
                          // shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                          child: const Icon(Icons.add, size:25 ),
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
                          onPressed: (){},
                          padding: const EdgeInsets.all(8),
                          color : Colors.lightBlue,
                          textColor: Colors.white,
                          // shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                          child: const Icon(Icons.remove, size:25 ),
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
    // and once added, now changeQuantity function will take care of rest
  addToCart() async {
    // start loading 
    showLoading(context);

    // start doing our stuff...
    
    dynamic newCart = [ ...context.read<MyProvider>().cart ]; // our current cart
    newCart.add({ // adding this product to our cart
        "product_id":widget.product["product_id"],
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
      dynamic data = jsonDecode(response.body);
      context.read<MyProvider>().setCart(newCart);
      assignProductCartQuantity();
    }catch(e){
        print(e);
    }finally{
      // end loading:
      Navigator.of(context).pop();
    }
  }
}