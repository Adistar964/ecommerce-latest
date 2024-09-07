

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
  int activeIndex = 0;

  goToBranch(branchIndex){
    setState(()=>activeIndex=branchIndex); // first set activeIndex for the bottomNavBar

    // homescreen-branch has index of 0, cartscreen-branch has index 1 and wishlist has index 2 and so on according to where they r in StatefulShellRoute.indexedStack in routerConfig file
    widget.navigationShell?.goBranch(branchIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell, // this will render different pages/routes in this body accordingly 
      // then our persistent bottomNavBar (only body will change with different routes, but not BottomNavBar)
      // this will be persistent and not re-render when screen changes
      bottomNavigationBar: MyBottomNavBar( onTapFunction: goToBranch, activeIndex: activeIndex)
      // MyBottomNavBar is from bottomNavBar.dart that we created
    );
  }
}