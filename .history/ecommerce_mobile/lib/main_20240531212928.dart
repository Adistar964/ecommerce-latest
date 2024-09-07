// different configs:
import "package:ecommerce_mobile/configuration/providerConfig.dart";
import "package:ecommerce_mobile/configuration/routerConfig.dart";
// for firebase
import "package:firebase_core/firebase_core.dart"; 
import "package:firebase_auth/firebase_auth.dart";
// flutter:
import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main() async { // it is async function, so that it waits for firebase to first initialise

  // initialising firebase:
  WidgetsFlutterBinding.ensureInitialized(); // needed for some reason before initialisation
  await Firebase.initializeApp( // initialising firebase with our app
    options: const FirebaseOptions(
      apiKey: "AIzaSyBAICs2toz4kjjMbvRlEj4OEe_3ZNbHwIk",
      appId: "test-project-1afe1.firebaseapp.com",
      messagingSenderId: "695544153237",
      projectId: "test-project-1afe1"
    )
  ); 
  // initialisation complete


  runApp( const MyApp() ); // we will run our created app
}


// our app will be wrapped inside a provider
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider is the type of Provider which re-renders the widgets if its values change 
    return ChangeNotifierProvider( 
      create: (context) => MyProvider(), // setting our created provider in this wrapper
      builder: (context,child) => const MyAppBody(), // passing our appBody inside this providerWrapper builder
      
    );
  }
}




class MyAppBody extends StatelessWidget {
  const MyAppBody ({super.key}); // shorthand constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( // basically MaterialApp, but we can give it our custom goRouter for routing
      title: "964 Ecommerce",
      // if theme style is provided, it is applied to the whole app:
      theme: ThemeData( fontFamily: "Poppins" ), // now whole app by default use "Poppins font" (We added that font manually)
      // initialRoute: FirebaseAuth.instance.currentUser == null ? "/login" : "/", // take us to login page if the user is not signed in, otherwise to home page
      // we will not be using routes:{"/something":...}, but we will use onGenerateRoute
      // onGenerateRoute also allows us to pass data to other screens
      // and it is also allows us to have some screen-change effect
      // onGenerateRoute: (settings) => MyRoutes(settings),
      routerConfig: MyRouter,
    );
  }

}
