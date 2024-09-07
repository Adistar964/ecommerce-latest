

import "package:flutter/material.dart";


// creating our provider here:
class MyProvider extends ChangeNotifier {
    // our provider variables/values:
    dynamic products; // this var stores all our products from mongoDB
    dynamic cart; // this var stores our cart-items
    dynamic wishlist; // this var stores our wishlist-items
    dynamic homeData; // this var stores our home-page-items
    dynamic dataLoaded = false; // this var checks if data(homepage,cart,wishlist,etc..) has been loaded
    // dataLoaded is initially false, as data hasnt loaded up initially => it is only set to true after data is laoded

    // Now we will create set-functions for the above variables:

    // similar to react: const [loading,setLoading] = useState()
    // but we r creating setLoading seperately
    setDataLoaded (value){ // this var updates our "loading" var we created above
      dataLoaded = value;
      notifyListeners(); // this is like setState => it re-renders the widgets
      // it will re-render all widgets using this provider's values
      // (the widgts that dont use provider at all will remain the same, so this way the app only updates required widgets instead of the whole app)
      // so now a new loading variable will be used in all those widgets using the loading variable
    }

    setCart (newCart){ // this var updates our "cart" var we created above
      cart = newCart;
      notifyListeners(); // this is like setState => it re-renders the widgets
      // it will re-render all widgets using this provider's values
      // (the widgts that dont use provider at all will remain the same, so this way the app only updates required widgets instead of the whole app)
      // so now a new cart variable will be used in all those widgets using the cart variable
    }

    setWishlist(newWishList){ // this var updates our "wishList" var we created above
      wishlist = newWishList;
      notifyListeners(); // update widgets using the provider-data
    }

    setProducts(prods){ // this var updates our "products" var we created above
      products = prods;
      notifyListeners(); // update widgets using the provider-data
    }

    setHomeData(data){ // this var updates our "homeData" var we created above
      homeData = data;
      notifyListeners(); // update widgets using the provider-data
    }


}
