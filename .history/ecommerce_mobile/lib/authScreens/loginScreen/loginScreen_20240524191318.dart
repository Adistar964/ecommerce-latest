

import 'package:ecommerce_mobile/authScreens/loginScreen/textField.dart';
import 'package:ecommerce_mobile/helper_components/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                      Icon(Icons.shopping_bag, size: 120, color: Colors.blueGrey[20]),
                      const SizedBox(height: 20), // leaving some space
                      // and then a light-colored text:
                      const Center(child:
                        Text("Welcome back! please sign in", style: TextStyle( fontSize: 17, letterSpacing: 2 ,color: Color.fromARGB(255, 84, 82, 82) ) )
                        ),
                      const SizedBox(height: 40), // leaving some space
                    // our email input field
                    // the below is the widget we created 
                    MyTextField( label:"Email", obscureText: false, controller:emailFieldController ),
                    // above, obscure means to show inputted text as *
                    const SizedBox(height: 20), // leaving some space
                    // our password input field
                    MyTextField( label:"Password",  obscureText: true , controller:passwordFieldController ),
                    const SizedBox(height: 7), // leaving some space
                    // and then a forgot password text
                    Align( // this helps us aligning => also, Center widget is a special case of this widget
                      alignment: Alignment.centerRight,
                      child: GestureDetector( // wrapped in GestureDetector so that we can have onTap event
                        onTap: () => Navigator.of(context).pushNamed("/forgotPassword"), // pressing " Forgot password " text will lead to its screen
                        child: const Text("Forgot Password?", style: TextStyle( fontSize: 16, color: Color.fromARGB(255, 89, 88, 88) ) )
                        ),
                    ),
                    const SizedBox(height: 25), // leaving some space
                    // A login button:
                    Container(
                      width: double.infinity, // takes complete width
                      child: ClipRRect( // a shorthand class to give borderradius for rounded borders
                        borderRadius: BorderRadius.circular(10),
                        child: MaterialButton( // a very customizable button
                          onPressed: ()=>processLogin(context), // this func will handle login things
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
                    // wrapped in GestureDetector so that we can have onTap event
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed("/signUp"), // moving to register-screen when user taps it
                      child: const Text(
                        "Don't have an account? register now",
                        style: TextStyle(
                          fontSize: 17
                        ),
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

  processLogin(context){
    var email = emailFieldController.text;
    var password = passwordFieldController.text;
    if ( EmailValidator.validate(email) && password.length > 8){ // if user wrote a proper email address in the email-field and also password greater than 8 charachters
        doLogin(context); // then contrinue to firebase-login
    }else if( !EmailValidator.validate(email) ){ // if user did not input a proper email
      showDialog( // show error!
          context: context, 
          builder: (context){
              return AlertDialog(
                title:const Text("Login Error"),
                content: const Text("Email is not valid!"),
                actions: [
                  Align(
                    alignment: Alignment.center, // aligning this button to the left
                    child: TextButton(
                      onPressed: ()=>Navigator.of(context).pop(), // removes this alertDialog
                      child: const Text("ok")
                      )
                  )
                ]
              );
            });
    }else{ // if user inputted password less than 8 charachters
      showDialog( // show error!
          context: context, 
          builder: (context){
              return AlertDialog(
                title:const Text("Login Error"),
                content: const Text("Password must be atleast 8 charachters long!"),
                actions: [
                  Align(
                    alignment: Alignment.center, // aligning this button to the left
                    child: TextButton(
                      onPressed: ()=>Navigator.of(context).pop(), // removes this alertDialog
                      child: const Text("ok")
                      )
                  )
                ]
              );
            });   
    }
  }

  doLogin(context){
      // show loading screen
      showLoading(context);
      
      // then do login stuff

        // always use FirebaseAuth.instance to use Firebase-Auth's functions
        FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailFieldController.text, // value of Email TextField
          password: passwordFieldController.text, // value of Password TextField
          ).then((credential){
              // basically login successful!

              // then remove loading screen
              Navigator.of(context).pop(); // dismisses the loading-dialog

              // the navigate to home page of the store
              Navigator.of(context).pushReplacementNamed("/home");
              // basically, when we navigate to homescreen, we want that to replace current login screen,
              // so that user cannot go back to login screen on back buttons
          }).catchError((error){
              // then remove loading screen
              Navigator.of(context).pop();
              // showing error dialogs:
              showDialog(context: context, builder: (context) => 
                  AlertDialog(
                    title: const Text("Login Error"),
                    content: const Text("Username or Password is incorrect"),
                    actions: [
                      TextButton(
                        onPressed: ()=>Navigator.of(context).pop() ,
                        child: const Text("retry")
                        )
                    ],
                  )
              );
          });
      
  }

}