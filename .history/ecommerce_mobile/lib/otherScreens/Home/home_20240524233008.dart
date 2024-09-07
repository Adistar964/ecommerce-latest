import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen ( {super.key} ); //shorthand constructor required

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        // appbar
        appBar: AppBar( 
          title: const Text("HOME", style: TextStyle(fontWeight: FontWeight.bold)) , 
          centerTitle: true,
          leading: const Icon(Icons.menu_rounded, weight: 50, size: 50),
          ),
      
        // app body
        body: const Center(child: Text( "Home Page!" )),
      );
  }
}