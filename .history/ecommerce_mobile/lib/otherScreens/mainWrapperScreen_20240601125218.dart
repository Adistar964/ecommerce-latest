

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import "package:badges/badges.dart" as badges;

// This is the main wrapper
// this will coontain the bottomnavigation bar
// this contains body that shows/holds the different pages
//This was created so that we could have a persistent bottomNavBar using goRouter 

class MainWrapperScreen extends StatefulWidget {
  final StatefulNavigationShell? navigationShell; // navigationShell to be passed in it which contains the config for the pages
  const MainWrapperScreen({super.key,this.navigationShell});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int selectedIndex = 0;

  goToBranch({branchIndex}){
    // here, homescreen-branch has index of 0, cartscreen-branch has index 1 and wishlist has index 2 and so on according to where they r in StatefulShellRoute.indexedStack in routerConfig file
    widget.navigationShell?.goBranch(branchIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell, // this will render different pages/routes in this body accordingly 
      // then our persistent bottomNavBar (only body will change with different routes, but not BottomNavBar)
      bottomNavigationBar: BottomNavigationBar( 
        selectedItemColor: Colors.blue,
        onTap: (index){
          setState(()=>selectedIndex=index); // first set activeIndex for the bottomNavBar
          goToBranch(branchIndex:index);
        },
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.black,
        items: [
          const BottomNavigationBarItem(label:"home" , icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(label:"cart" , icon: badges.Badge(
                  badgeContent: Text("${Provider.of<MyProvider>(context).cart?.length}"),  // using .watch() so that it listens for changes
                  // ? is used for null-safety, this expression wont continue if "cart" is null
                  // basically the expression will return an empty string(nothing at all) when the cart var is null
                  // if .cart is not null, it will access its length property
                  badgeAnimation: const badges.BadgeAnimation.scale(),
                  showBadge: Provider.of<MyProvider>(context).cart?.length != 0, // only show this badge is there is atleast 1 item in the cart
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.shopping_cart_outlined, size:30),
                  )
                )),
          const BottomNavigationBarItem(label:"wishlist" , icon: Icon(Icons.favorite_outline)),
          const BottomNavigationBarItem(label:"profile" , icon: Icon(Icons.person_outline)),
        ],
      ), // this will be persistent and not re-render when screen changes
    );
  }
}