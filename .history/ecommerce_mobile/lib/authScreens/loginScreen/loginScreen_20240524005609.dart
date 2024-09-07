

import 'package:ecommerce_mobile/authScreens/loginScreen/textField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      // we will only have a body
      body: SafeArea(
        child: SingleChildScrollView( // wrapped in this, so that it removes that overflow warning
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only( right:35, left:35 ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch, // this will make every widget in it stretch to 100% width in x-direction especially the buttons
                  children: [
                      const SizedBox(height: 40), // leaving some space
                      const Icon(Icons.store, size: 120),
                      const SizedBox(height: 20), // leaving some space
                      // and then a light-colored text:
                      const Center(child:
                        Text("Welcome back! please sign in", style: TextStyle( fontSize: 17, letterSpacing: 2 ,color: Color.fromARGB(255, 84, 82, 82) ) )
                        ),
                      const SizedBox(height: 40), // leaving some space
                    // our email input field
                    // the below is the widget we created 
                    LoginTextField( label:"Email", obscureText: false, controller:emailFieldController ),
                    // above, obscure means to show inputted text as *
                    const SizedBox(height: 20), // leaving some space
                    // our password input field
                    LoginTextField( label:"Password",  obscureText: true , controller:passwordFieldController ),
                    const SizedBox(height: 7), // leaving some space
                    // and then a forgot password text
                    const Align( // this helps us aligning => also, Center widget is a special case of this widget
                      alignment: Alignment.centerRight,
                      child: Text("Forgot Password?", style: TextStyle( fontSize: 16, color: Color.fromARGB(255, 89, 88, 88) ) ),
                    ),
                    const SizedBox(height: 25), // leaving some space
                    // A login button:
                    Container(
                      width: double.infinity, // takes complete width
                      child: ClipRRect( // a shorthand class to give borderradius for rounded borders
                        borderRadius: BorderRadius.circular(10),
                        child: MaterialButton( // a very customizable button
                          onPressed: (){},
                          color: Colors.black,
                          padding: const EdgeInsets.all(20),
                          child: const Text("Sign in", style: TextStyle( fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold ) )),
                      ),
                    ),
                    const SizedBox(height: 20), // leaving some space
                    const Row(children: [
                      Expanded(child: Divider(thickness:2) ),
                      Text("   Or continue using   ", style: TextStyle( fontSize: 20, color: Color.fromARGB(255, 89, 88, 88) ) ),
                      Expanded(child: Divider(thickness:2) ),
                    ]),
                    // google button
                    Container(
                      margin: const EdgeInsets.only( top: 10,bottom: 50  ),
                      width: 75,
                      height: 75,
                      child: OutlinedButton(
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(  // look into docs for "shape"
                                side: const BorderSide( color: Color.fromARGB(255, 117, 117, 117) ),
                                borderRadius: BorderRadius.circular(10)
                           ),
                        ),
                        child: Image.asset("images/google_logo.png"), /// in our images folder and also added to assets section in pubspec.yaml
                        ),
                    ),
          
                    // register link
                    const Text(
                      "Don't have an account? register now",
                      style: TextStyle(
                        fontSize: 17
                      ),
                      )
                  ],
                ),
              ) 
          ),
        ),
      ) 
    );
  }
}