

import "package:flutter/material.dart";


// creating our provider here:
class MyProvider extends ChangeNotifier {
    // our provider variables/values:
    bool? loading; // a loading var  => "?" means it can also take up a null value instead of a bool
    dynamic products; // this var stores all our products from mongoDB
    Map? cart; // this var stores our cart-items
    Map? wishlist; // this var stores our wishlist-items

    // Now we will create set-functions for the above variables:

    // similar to react: const [loading,setLoading] = useState()
    // but we r creating setLoading seperately
    setLoading (isLoaoding){ // this var updates our "loading" var we created above
      loading = isLoaoding;
      ChangeNotifier(); // this is like setState => it re-renders the widgets
      // it will re-render all widgets using this provider's values
      // (the widgts that dont use provider at all will remain the same, so this way the app only updates required widgets instead of the whole app)
      // so now a new loading variable will be used in all those widgets using the loading variable
    }

    setCart (newCart){ // this var updates our "cart" var we created above
      cart = newCart;
      ChangeNotifier(); // this is like setState => it re-renders the widgets
      // it will re-render all widgets using this provider's values
      // (the widgts that dont use provider at all will remain the same, so this way the app only updates required widgets instead of the whole app)
      // so now a new cart variable will be used in all those widgets using the cart variable
    }

    setWishlist(newWishList){ // this var updates our "wishList" var we created above
      wishlist = newWishList;
      ChangeNotifier(); // update widgets using the provider-data
    }

    setProducts(prods){ // this var updates our "products" var we created above
      products = prods;
      ChangeNotifier(); // update widgets using the provider-data
    }


}
