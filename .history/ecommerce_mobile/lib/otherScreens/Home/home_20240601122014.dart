import "dart:convert";
import "dart:isolate";

import "package:ecommerce_mobile/configuration/constants.dart";
import "package:ecommerce_mobile/configuration/providerConfig.dart";
import "package:ecommerce_mobile/helper_components/bottomNavbar.dart";
import "package:ecommerce_mobile/helper_components/loading.dart";
import "package:ecommerce_mobile/otherScreens/home/adCarousel.dart";
import "package:ecommerce_mobile/otherScreens/home/categories.dart";
import "package:ecommerce_mobile/otherScreens/home/imagesAndProds.dart";
import "package:ecommerce_mobile/otherScreens/home/searchInput.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:badges/badges.dart" as badges; // altho badges are also there in flutter, but this is more better
import "package:http/http.dart";
import "package:provider/provider.dart";

// Our homescreen Widget will be a Stateful one, cz we need to first initially fetch data form backend using intiState functions which is only available in stateFulWidget
// and then set it to our corresponding variables in the provider
// Then those variables will be used by other Widgets in our app using provider-package (similar to provider in react)
class HomeScreen extends StatefulWidget {
 //shorthand constructor required
  const HomeScreen ( {super.key} ); 
  
  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool loading = true; // loading state-variable => if true, then loadingScreen widget will be shown

  @override
  void initState() {

    // our functionality
    if(context.mounted){ // first let the app be mounted/set-up

        // start fetching data
        // now there is a situation:
        // if user opens homescreen, our app will fetch data from backend form getData function
        // but if user goes to some other screen and then comes back to homeScreen, the app will again fetch data from backend unneccessarily
        // therefore, after initially getting data in our homescreen, dataLoaded iis kept to true
        // next time when our app comes back here, it knows that data has been loaded, so then it wont fetch the data again
        // therefore, only fetch data if data hasnt been loaded initially
        if(context.read<MyProvider>().dataLoaded == false){
          getData();
        }
    }

    // we will not replace initState function from parent-class ,
    // but just extend it, so then after adding our functionality above,
    // we will then run this default initState function
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
      if(loading || Provider.of<MyProvider>(context).cart == null){ // Provider.of method is a secure method to call inside build method
        // loading will appear until the cart is loaded => i.e, it is not null, and other data has been loaded form backend too
        return const LoadingScreen();
      }else{
        return mainBody();
      }
  }

  mainBody() {
      return SafeArea(  // so it doesn collide the notification-bar, etc..
        child: Scaffold(
          backgroundColor: Colors.grey[170],
          // appbar
          appBar: AppBar( 
            title: Row(
              children: [
                const Expanded(
                  child: Center(
                    child: Text("964 SHOP", style: TextStyle(fontWeight: FontWeight.bold) )
                    )
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: badges.Badge(
                    badgeContent: Text("${context.watch<MyProvider>().cart?.length}"),  // using .watch() so that it listens for changes
                    // ? is used for null-safety, this expression wont continue if "cart" is null
                    // basically the expression will return an empty string(nothing at all) when the cart var is null
                    // if .cart is not null, it will access its length property
                    badgeAnimation: const badges.BadgeAnimation.scale(),
                    showBadge: context.watch<MyProvider>().cart?.length != 0, // only show this badge is there is atleast 1 item in the cart
                    child: IconButton(
                      onPressed: (){
                        print(context.read<MyProvider>().cart);
                      },
                      icon: const Icon(Icons.shopping_cart, size:30),
                      ),
                  )
                )
              ]
            ) ,
            leading: IconButton(
              onPressed:(){},
             icon: const Icon(Icons.apps, weight: 50, size: 35)
             ),
            
            ),
        
          // app body
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                SearchInput(),
                const SizedBox(height: 20), // leaving some space
                const CategoryCirclesContainer(),
                const Divider(height: 10, color: Colors.black,), // putting a divider
                const SizedBox(height: 17), // leaving some space
                const AdCarousel(), // our component
                const SizedBox(height: 20), // leaving some space
                const FeaturedProductsContainer(),
              ]
            ),
          ),
        ),
      );
  }

  getData() async {
    // start loading
    setState(() {
      loading = true;
    });
    // anything before variable_name is basically its dtype (u could also give dynamic/final/var)
    Uri url = Uri.parse("$backend_url/getHomePageContent/"); 
    // url should be converted to Uri dtype for it to be passed in http's get method
    Response response = await get( url );
    final data = jsonDecode(response.body);
    context.read<MyProvider>().setHomeData(data);
    // instead of above, u could also do: (original method)
    // Provider.of<MyProvider>(context, listen: false).setHomeData(data); //  listen:false for .read()
    
    // now getting user-cart and wishlist
    getWishlist(); 
    getCart();

    // end loading
    context.read<MyProvider>().setDataLoaded(true); // telling app that data (user cart,wihslist,etc..) has been loaded
    setState(() {
      loading = false;
    });
  }

  // gets user-data like (user's wishlist)
  getWishlist() async {
        Map body = {
            "uid": FirebaseAuth.instance.currentUser?.uid
        };
        Uri url = Uri.parse("$backend_url/getFavourites/");

        Response response = await post(url, 
            headers:{"Content-Type":"application/json"},
            body : jsonEncode(body)
        );

        final data = jsonDecode(response.body);

        context.read<MyProvider>().setWishlist(data["user_favourites"]);
  }

  // gets user-data (user's cart)
  getCart() async {
        Map body = {
            "uid": FirebaseAuth.instance.currentUser?.uid
        };
        Uri url = Uri.parse("$backend_url/getCart/");

        Response response = await post(url, 
            headers:{"Content-Type":"application/json"},
            body : jsonEncode(body)
        );

        final data = jsonDecode(response.body);

        context.read<MyProvider>().setCart(data["cart_items"]);
  }
}

