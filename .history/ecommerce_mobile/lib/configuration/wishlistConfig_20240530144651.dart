import 'dart:convert';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

// toggleFav work procedure:
// if a product is not in wishlist, it will be added
// it it is present, then it will be removed form the wishlist


Future<bool?> toggleFav(context, product, callBackAfterSuccess,isLiked) async{
    try{
      // we used Provider.of method to access the provider, but context.read could also be used
      dynamic newWishlist = [...Provider.of<MyProvider>(context,listen: false).wishlist];
      dynamic existsInWislist = false;
      for (var wishItem in newWishlist){
        if(wishItem["product_id"] == product["_id"]){ // checking if product is in the wishlist
            existsInWislist = true;
            break; // break free from the loop as everything here is done
        }
      }
      if(existsInWislist){ // first check if product in wishlist
          // if product present in wishlist then:
          // we will remove it from the wishlist
          print("exists, but now will be removed");
          newWishlist.removeWhere( (item) => item["product_id"]==product["_id"] );
      }else{
          // if product absent in wishlist then:
          // we will add it to the wishlist
          print("absent, but now will be added");
          newWishlist.add({
              "product_id":product["_id"],
              "thumbnail":product["thumbnail"],
              "price":product["price"],
              "product_name":product["title"],
              "discountPrice":product["discountPrice"],
              "maxQuantityForAUser":product["maxQuantityForAUser"] // the max.amount of this item that user can add in cart
          });
      }
      Provider.of<MyProvider>(context,listen: false).setWishlist(newWishlist);
      // now we will send this newWishlist to our backend
      Map body = {
        "uid":FirebaseAuth.instance.currentUser?.uid,
        "update_query":{ "\$set" : {"user_favourites":newWishlist} }
      };
      Uri url = Uri.parse("$backend_url/updateUserDoc/");
      await post(
        url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(body)
      );
      callBackAfterSuccess();
      return !isLiked; // we are coobliged to return as likedButton says so :( // we will return the opposite of isLiked
      // example: if isLiked was true, then after pressing likeButton, it returns false => therefore toggling behaviour
    }catch(e){
      print(e);
      return null;
    }
}

  // this will check if the product is in the wishlist and then updates isFav variable accordingly
  checkFav(context,{product,wishlistExistsCallback,wishlistAbsentCallback}){
    // from above, wishlistExistsCallback will run if the products exists in the wishlist
    // wishlistAbsentCallback will run if the product is absent from the wishlist
    // these 2 functions do nothing but just update the state in their respective classes
      if(Provider.of<MyProvider>(context,listen:false).wishlist != null){ // first check if it is loaded from backend
            String productId = product["_id"];
            dynamic wishlist = Provider.of<MyProvider>(context,listen:false).wishlist;
            dynamic exists = false; // we will check if the item exists in the wishlist, if not then we will set the item's quantity to 0
            
            for (var item in wishlist){
              if (item["product_id"] == productId){ // checking if there in wishlist
                exists = true;
                break; // then break free from the loop once we found the product in the wishlist
              }
            }

            if(exists==true){  // first check if the product exists in the wishlist
              // if it exists, run wishlistExistsCallback
              wishlistExistsCallback();

            }else{
              print("absent!");
              wishlistAbsentCallback();
            }
      }
  }