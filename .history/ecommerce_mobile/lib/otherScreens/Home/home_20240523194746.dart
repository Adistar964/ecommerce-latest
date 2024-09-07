import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen ( {super.key} ); //shorthand constructor required

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        // appbar
        appBar: AppBar( title: const Text("Home page") , centerTitle: true,),
      
        // app body
        body: const Center(child: Text( "Home Page!" )),
      );
  }
}