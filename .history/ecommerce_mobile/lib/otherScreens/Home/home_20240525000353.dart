import "package:ecommerce_mobile/authScreens/loginScreen/textField.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";

class HomeScreen extends StatelessWidget {
  HomeScreen ( {super.key} ); //shorthand constructor required

  final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[150],
        // appbar
        appBar: AppBar( 
          title: Row(
            children: [
              const Expanded(
                child: Center(
                  child: Text("964 SHOP", style: TextStyle(fontWeight: FontWeight.bold) )
                  )
                ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.shopping_cart, size:30),
                  )
              )
            ]
          ) ,
          leading: IconButton(
            onPressed:(){},
           icon: const Icon(Icons.menu_rounded, weight: 50, size: 35)
           ),
          
          ),
      
        // app body
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: searchFieldController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    hintText: "What are you looking for?",
                    border: OutlineInputBorder( borderRadius: BorderRadius.circular(4) ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider( color: Colors.black )
            ]
          ),
        ),
      );
  }
}