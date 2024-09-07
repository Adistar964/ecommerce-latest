import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen ( {super.key} ); //shorthand constructor required

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        // appbar
        appBar: AppBar( 
          title: const Row(
            children: [
              Expanded(child: Center(child: Text("HOME", style: TextStyle(fontWeight: FontWeight.bold)))),
              Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 12,
                  child: Icon(Icons.account_box_rounded, size:40),
                ),
              )
            ]
          ) , 
          centerTitle: true,
          leading: const Icon(Icons.menu_rounded, weight: 50, size: 35),
          
          ),
      
        // app body
        body: const Center(child: Text( "Home Page!" )),
      );
  }
}