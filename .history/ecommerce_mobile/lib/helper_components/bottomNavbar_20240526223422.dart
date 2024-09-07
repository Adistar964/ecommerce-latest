import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label:"home" , icon: Icon(Icons.home)),
          BottomNavigationBarItem(label:"cart" , icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(label:"wishlist" , icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label:"profile" , icon: Icon(Icons.account_circle_outlined)),
        ],
    );
  }
}