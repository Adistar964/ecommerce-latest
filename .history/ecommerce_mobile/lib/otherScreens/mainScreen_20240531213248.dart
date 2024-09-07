

import 'package:ecommerce_mobile/helper_components/bottomNavbar.dart';
import 'package:flutter/material.dart';

// This is the main wrapper
// this will coontain the bottomnavigation bar
// this contains body that shows/holds the different pages
//This was created so that we could have a persistent bottomNavBar using goRouter 

class MainWrapperScreen extends StatelessWidget {
  final navigationShell; // navigationShell to be passed in it which contains the config for the pages
  const MainWrapperScreen({super.key,this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // this will render different pages/routes in this body accordingly 
      bottomNavigationBar: const CustomBottomNavBar(activeIndex: 0), // this will be persistent and not re-render when screen changes
    );
  }
}