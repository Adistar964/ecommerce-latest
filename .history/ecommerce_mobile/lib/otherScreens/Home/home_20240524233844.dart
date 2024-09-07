import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen ( {super.key} ); //shorthand constructor required

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        // appbar
        appBar: AppBar( 
          title: Row(
            children: [
              const Expanded(child: Center(child: Text("HOME", style: TextStyle(fontWeight: FontWeight.bold)))),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: (){},
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder()
                  ),
                  child: Icon(Icons.account_circle_outlined, size:40, color: Colors.blue[200],) 
                  )
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