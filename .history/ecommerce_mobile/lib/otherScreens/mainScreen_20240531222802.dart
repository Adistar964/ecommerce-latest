

import 'package:ecommerce_mobile/helper_components/bottomNavbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    widget.navigationShell?.goBranch(branchIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell, // this will render different pages/routes in this body accordingly 
      bottomNavigationBar: BottomNavigationBar( 
        selectedItemColor: Colors.blue,
        onTap: (index){
          setState(()=>selectedIndex=index); // first set activeIndex for the bottomNavBar
          goToBranch(branchIndex:index);
        },
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(label:"home" , icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(label:"cart" , icon: Icon(Icons.shopping_cart_outlined)),
          BottomNavigationBarItem(label:"wishlist" , icon: Icon(Icons.favorite_outline)),
          BottomNavigationBarItem(label:"profile" , icon: Icon(Icons.person_outline)),
        ],
      ), // this will be persistent and not re-render when screen changes
    );
  }
}