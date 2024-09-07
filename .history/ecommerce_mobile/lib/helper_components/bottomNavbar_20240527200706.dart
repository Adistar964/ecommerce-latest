import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar( 
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(label:"home" , icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(label:"cart" , icon: Icon(Icons.shopping_cart_outlined)),
          BottomNavigationBarItem(label:"wishlist" , icon: Icon(Icons.favorite_outline)),
          BottomNavigationBarItem(label:"profile" , icon: Icon(Icons.person_outline)),
        ],
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // we couldve used flutter's BottomNavigator but we will use third party package:
    // "google_nav_bar"
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav( 
            color: Colors.black,
            activeColor: Colors.blue,
            // backgroundColor: Colors.grey[200],
            gap: 10,
            tabActiveBorder: Border.all(color: Colors.blueAccent),
            padding: EdgeInsets.all(10),
            // unselectedItemColor: Colors.black,
            tabs: const [
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