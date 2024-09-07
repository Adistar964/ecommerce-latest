import 'dart:convert';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for vibration effects
import 'package:http/http.dart';
import 'package:provider/provider.dart';

// first time adding smth to cart
// this will add that item to user's cart
// and once added, now Quantity-functions below will take care of rest
addToCart(context,product) async {
  
  HapticFeedback.selectionClick(); // a sort of vibration effect to know users they have added smth to cart

  dynamic newCart = [ ...Provider.of<MyProvider>(context,listen:false).cart ]; // our current cart (we will make changes to it)
  newCart.add({ // adding this product to our cart
      "product_id":product["_id"],
      "quantity":1,
      "thumbnail":product["thumbnail"],
      "price":product["price"],
      "product_name":product["title"],
      "discountPrice":product["discountPrice"],
      "maxQuantityForAUser":product["maxQuantityForAUser"]
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
    Provider.of<MyProvider>(context,listen:false).setCart(newCart);
  }catch(e){
      print(e);
  }
}


// quantity functions ////////////////////////////////////

  
subtractQuantity(context,product) async {
  try{
    dynamic newCart = [ ...Provider.of<MyProvider>(context,listen:false).cart ]; // our current cart (we will make changes to it)
    for (var item in newCart){
      if(item["product_id"] == product["_id"]){ // first find the item in the cart

          if(item["quantity"] == 1){ // if quantity is 1, and hence user clicked "-" button, we will remove the product from the cart itself
            newCart.removeWhere((item) => item["product_id"]==product["_id"]); // remove the item from the cart which has the product_id as specified
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
          Provider.of<MyProvider>(context,listen:false).setCart(newCart);
          
          break; // break free from the loop as we r done
      }
    }
  }catch(e){
    print(e);
  }
}

addQuantity(context,product) async {
  try{
    dynamic newCart = [ ...Provider.of<MyProvider>(context,listen:false).cart ];
    for (var item in newCart){
      if(item["product_id"] == product["_id"]){ // first find the item in the cart
        if(item["quantity"] == item["maxQuantityForAUser"]){ // if quantity reached its maxLimit, and hence user clicked "+" button, we will show an alert
            print("already maxQuantity, so nothing will be done!");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar( content: Text("The quantity has reached its max limit") )
            // );
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
          Provider.of<MyProvider>(context,listen:false).setCart(newCart);
        }
        break; // break free from the loop as we r done
      }
    }
  }catch(e){
    print(e);
  }
}


removeFromCart(context,product) async {
  try{
    dynamic newCart = [ ...Provider.of<MyProvider>(context,listen:false).cart ]; // our current cart (we will make changes to it)
    for (var item in newCart){
      if(item["product_id"] == product["_id"]){ // first find the item in the cart
          newCart.removeWhere((item) => item["product_id"]==product["_id"]); // remove the item from the cart which has the product_id as specified
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
          Provider.of<MyProvider>(context,listen:false).setCart(newCart);          
          break; // break free from the loop as we r done
      }
    }
  }catch(e){
    print(e);
  }
}


// this below function will be used to move wishlist to cart 
// => add all items from wishlist to cart while also maintaining maxQuantityForAUser
moveWishlistToCart(context){
  dynamic wishlist = [...Provider.of<MyProvider>(context, listen: false).wishlist];
  dynamic cart = [...Provider.of<MyProvider>(context, listen: false).cart];

  for(var wishlistItem in wishlist){
    wishlistItem["_id"] = wishlistItem["product_id"]; // as quantityInCart, addToCart, addQuantity uses "_id" property to work 
    int cartQuantity = quantityInCart(wishlistItem, cart);
    print(wishlistItem["title"]);
    if(cartQuantity == 0){ // if wishlist-item not there in cart
        addToCart(context, wishlistItem);
    }else{ // if already present in cart
        addQuantity(context, wishlistItem);
    }
  }
}


// the below function will return a product's quantity in cart
quantityInCart(product, cart){
  dynamic quantity = 0; // after we find the product in the cart, we will set its quantity variable accrodingly, but initially we will put it to zero
  for(var cartItem in cart){
    if(cartItem["product_id"] == product["_id"]){
      // if it exists, update the "quantity" variable
      quantity = cartItem["quantity"];
    }
  }
  return quantity; // it will return 0 if the item wasnt in the cart
}