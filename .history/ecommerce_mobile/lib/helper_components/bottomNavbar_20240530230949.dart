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
            duration: const Duration(milliseconds: 25),
            color: Colors.black,
            activeColor: Colors.blue,
            // backgroundColor: Colors.grey[200],
            gap: 20,
            tabActiveBorder: Border.all(color: Colors.blueAccent),
            padding: const EdgeInsets.all(10),
            selectedIndex: activeIndex,
            // unselectedItemColor: Colors.black,
            tabs: [
              GButton(text:"Home" , icon: Icons.home_outlined, onPressed: ()=>Navigator.pushNamed(context, "/")),
              GButton(text:"Cart" , icon: Icons.shopping_cart_outlined, onPressed: ()=>Navigator.pushNamed(context, "/cart")),
              GButton(text:"Wishlist" , icon: Icons.favorite_outline, onPressed: ()=>Navigator.pushNamed(context, "/signUp")),
              GButton(text:"Profile" , icon: Icons.person_outline, onPressed: ()=>Navigator.pushNamed(context, "/login")),
            ],
        ),
      ),
    );
  }
}