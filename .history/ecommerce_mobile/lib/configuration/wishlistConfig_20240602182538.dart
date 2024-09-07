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
      dynamic existsInWislist = isFavourite(product, Provider.of<MyProvider>(context,listen: false).wishlist);
      if(existsInWislist){ // first check if product in wishlist
          // if product present in wishlist then:
          // we will remove it from the wishlist
          newWishlist.removeWhere( (item) => item["product_id"]==product["_id"] );
      }else{
          // if product absent in wishlist then:
          // we will add it to the wishlist
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
      return !isLiked; // we are obliged to return as likedButton says so :( // we will return the opposite of isLiked
      // example: if isLiked was true, then after pressing likeButton, it returns false => therefore toggling behaviour
    }catch(e){
      print(e);
      return null;
    }
}



// the below function will return a product's quantity in cart
isFavourite(product, wishlist){
  bool isFav = false; // after we find the product in the wishlist, we will set its isFav variable accrodingly, but initially we will put it to false
  for(var wishlistItem in wishlist){
    if(wishlistItem["product_id"] == product["_id"]){
      // if it exists, update the "isFav" variable
      isFav = true;
    }
  }
  return isFav; // it will return 0 if the item wasnt in the cart
}