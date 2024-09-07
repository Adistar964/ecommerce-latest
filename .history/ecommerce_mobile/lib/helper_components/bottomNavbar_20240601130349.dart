import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import "package:badges/badges.dart" as badges;

class MyBottomNavBar extends StatelessWidget {
  final dynamic onTapFunction;
  final dynamic selectedIndex;
  const MyBottomNavBar({super.key,this.onTapFunction,this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Provider.of<MyProvider>(context).dataLoaded ? // only start showing this bottomNavBar when data has been loaded from the backend, otherwise we dont want this BottomNavBar with loading screen
      BottomNavigationBar( 
        selectedItemColor: Colors.blue,
        onTap: onTapFunction,
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.black,
        items: [
          const BottomNavigationBarItem(label:"home" , icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(label:"cart" , icon: badges.Badge(
                  badgeContent: Text(
                    "${Provider.of<MyProvider>(context).cart?.length}",
                    style: const TextStyle(color: Colors.white),
                    ),
                  // ? is used for null-safety, this expression wont continue if "cart" is null
                  // basically the expression will return an empty string(nothing at all) when the cart var is null
                  // if .cart is not null, it will access its length property
                  badgeAnimation: const badges.BadgeAnimation.scale(),
                  showBadge: Provider.of<MyProvider>(context).cart?.length != 0, // only show this badge is there is atleast 1 item in the cart
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Icon(Icons.shopping_cart_outlined, size:30),
                  )
                )),
          const BottomNavigationBarItem(label:"wishlist" , icon: Icon(Icons.favorite_outline)),
          const BottomNavigationBarItem(label:"profile" , icon: Icon(Icons.person_outline)),
        ],
      ) 
      : const Text(""); // show nothing if data hasnt been loaded;
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final activeIndex;
  const CustomBottomNavBar({super.key,this.activeIndex});

  @override
  Widget build(BuildContext context) {
    // we couldve used flutter's BottomNavigator but we will use third party package:
    // "google_nav_bar"
    return Container(
      color: Colors.grey[300],
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav( 
            duration: const Duration(milliseconds: 100),
            color: Colors.black,
            activeColor: Colors.blue,
            // backgroundColor: Colors.grey[200],
            gap: 20,
            tabActiveBorder: Border.all(color: Colors.blueAccent),
            padding: const EdgeInsets.all(10),
            selectedIndex: activeIndex,
            // unselectedItemColor: Colors.black,
            tabs: [
              GButton(text:"Home" , icon: Icons.home_outlined),
              GButton(text:"Cart" , icon: Icons.shopping_cart_outlined),
              GButton(text:"Wishlist" , icon: Icons.favorite_outline),
              GButton(text:"Profile" , icon: Icons.person_outline),
            ],
        ),
      ),
    );
  }
}