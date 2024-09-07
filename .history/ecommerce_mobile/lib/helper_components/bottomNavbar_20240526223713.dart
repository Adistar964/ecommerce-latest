import 'package:flutter/material.dart';

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
          BottomNavigationBarItem(label:"profile" , icon: Icon(Icons.account_circle_outlined)),
        ],
    );
  }
}