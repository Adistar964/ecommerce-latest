import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // we couldve used flutter's BottomNavigator but we will use third party package:
    // "google_nav_bar"
    return const GNav( 
        // selectedItemColor: Colors.blue,
        // unselectedItemColor: Colors.black,
        tabs: [
          GButton(text:"home" , icon: Icons.home_outlined),
          GButton(text:"cart" , icon: Icons.shopping_cart_outlined),
          GButton(text:"wishlist" , icon: Icons.favorite_outline),
          GButton(text:"profile" , icon: Icons.person_outline),
        ],
    );
  }
}