import "package:ecommerce_mobile/configuration/providerConfig.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

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
                    border: OutlineInputBorder( borderRadius: BorderRadius.circular(8) ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // leaving some space
              const Divider( color: Colors.black ),
              const SizedBox(height: 30), // leaving some space
              MaterialButton(
                onPressed: (){
                  // FirebaseAuth.instance.signOut();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                        print(context.read<MyProvider>().products);
                    }
                  });
                  
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text("Logout"),
              )
            ]
          ),
        ),
      );
  }
}