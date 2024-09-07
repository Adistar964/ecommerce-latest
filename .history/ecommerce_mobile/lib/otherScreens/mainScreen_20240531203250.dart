

import 'package:ecommerce_mobile/helper_components/bottomNavbar.dart';
import 'package:flutter/material.dart';

// This is the main wrapper
// this will coontain the bottomnavigation bar
// this contains body that shows/holds the different pages
//This was created so that we could have a persistent bottomNavBar using goRouter 

class MainWrapperScreen extends StatelessWidget {
  final page; // page to be passed in it
  const MainWrapperScreen({super.key,this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
      bottomNavigationBar: const CustomBottomNavBar(activeIndex: 0), // this will be persistent and not re-render when screen changes
    );
  }
}