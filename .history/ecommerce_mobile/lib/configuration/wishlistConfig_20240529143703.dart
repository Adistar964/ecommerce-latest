import 'dart:convert';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

// here we will  a function: toggleFav
// if a product is not in wishlist, it will be added
// it it is present, then it will be removed form the wishlist


toggleFav(context, product, callBackAfterSuccess) async{
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
    }catch(e){
      print(e);
    }
}