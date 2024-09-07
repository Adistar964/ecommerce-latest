import 'dart:convert';

import 'package:ecommerce_mobile/authScreens/loginScreen/textField.dart';
import 'package:ecommerce_mobile/helper_components/alert.dart'; // for our alert function
import 'package:ecommerce_mobile/helper_components/loading.dart'; // for the loading screen
import 'package:email_validator/email_validator.dart'; // for validating user-typed email
import 'package:firebase_auth/firebase_auth.dart'; // for firebase auth functions
import 'package:ecommerce_mobile/configuration/constants.dart'; // constants like currency
import 'package:http/http.dart'; // for doing api requests
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final retypePasswordFieldController = TextEditingController();

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
                      const SizedBox(height: 30), // leaving some space
                      Icon(Icons.shopping_bag, size: 95, color: Colors.blueGrey[20]),
                      const SizedBox(height: 20), // leaving some space
                      // and then a light-colored text:
                      const Center(child:
                        Text("Register your account", style: TextStyle( fontSize: 17, letterSpacing: 2 ,color: Color.fromARGB(255, 84, 82, 82) ) )
                        ),
                      const SizedBox(height: 40), // leaving some space
                    // our email input field
                    // the below is the widget we created 
                    MyTextField( label:"Email", obscureText: false, controller:emailFieldController ),
                    // above, obscure means to show inputted text as *
                    const SizedBox(height: 20), // leaving some space
                    // our password input field
                    MyTextField( label:"Password",  obscureText: true , controller:passwordFieldController ),
                    const SizedBox(height: 20), // leaving some space
                    // our retype-password input field
                    MyTextField( label:"Retype Password",  obscureText: true , controller:retypePasswordFieldController ),
                    const SizedBox(height: 25), // leaving some space
                    // A login button:
                    Container(
                      width: double.infinity, // takes complete width
                      child: ClipRRect( // a shorthand class to give borderradius for rounded borders
                        borderRadius: BorderRadius.circular(10),
                        child: MaterialButton( // a very customizable button
                          onPressed: () => validateAndSignUp(context),
                          color: Colors.black,
                          padding: const EdgeInsets.all(20),
                          child: const Text("Register", style: TextStyle( fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold ) )),
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
          
                    // login link
                    // wrapped in GestureDetector so that we can have onTap event
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed("/login"), // moving to register-screen when user taps it
                      child: const Text(
                          "Already have an account? then Sign In",
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

  validateAndSignUp(context){
    // this firsts validates whatever user wrote in the register-form and then creates the user-account
    var email = emailFieldController.text;
    var password = passwordFieldController.text;
    var retypePassword = retypePasswordFieldController.text;
    // if user wrote a proper email address and also password greater than 8 charachters
    // also both password field match, only then we continue to firebase account creation
    if( !EmailValidator.validate(email) ){
        // we will show an error dialog
        // alert is function we created from alert.dart in helper_components
        alert(context, "Invalid Email", "Please type a valid email address!");
    }else if ( password.length < 8 ){
        alert(context, "Password too short", "Password must be atleast 8 charachters long!");
    }else if( password != retypePassword ){
        alert(context, "Password dont match!", "Please type the same password on both the password fields.");
    }else{ // if no error, then we continue to registering
        doSignUp(context);
    }
    
  }

  doSignUp(context){
      // show loading screen
      showLoading(context);
      
      // then do login stuff

        // always use FirebaseAuth.instance to use Firebase-Auth's functions
        FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailFieldController.text, // value of Email TextField
          password: passwordFieldController.text, // value of Password TextField
          ).then((credential){
              // basically registering successful!

              //create the document for this user in our mongoDB
              createUserDoc(context); // 

          }).catchError((error){
              // then remove loading screen
              Navigator.of(context).pop();
              // showing error dialog: (our own function below)
              alert(context, "Register Error", "Username or password is incorrect");
          });
    }

    createUserDoc(context) async {
        // this function will create the document for this user in our mongoDB when the user first registers
        // The doc contains user's info like cart and wishList items

        try{
          Map body = {
            "uid": FirebaseAuth.instance.currentUser?.uid,
            "cart_items":[],
            "user_favourites":[]
          };
          String url = "$backend_url/updateUserDoc/";
          
          var response = await post(
            Uri.parse(url), // url must be passed inside this parse function for it to work!
            headers: { 
              "Content-Type":"application/json"
             },
             body: jsonEncode(body) // converting our Map-type body to JSON-type before sending it over to backend
          );

          var dataFromApi = jsonDecode(response.body); // converting json data back to dart data after response
          // basically the above dataFromApi is not needed, but It was made to show how response can be converted back from json
          // now everything is complete!
          // then remove loading screen
          Navigator.of(context).pop(); // dismisses the loading-dialog

          // the navigate to home page of the store
          Navigator.of(context).pushReplacementNamed("/home");
          // basically, when we navigate to homescreen, we want that to replace current login screen,
          // so that user cannot go back to login screen on back buttons
        }catch(e){
          // then remove loading screen
          Navigator.of(context).pop(); // dismisses the loading-dialog
          alert(context, "error", "Sorry! something went wrong.");
        }
    }

}