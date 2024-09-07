import 'package:ecommerce_mobile/authScreens/SignUpScreen/signUpScreen.dart';
import 'package:ecommerce_mobile/authScreens/loginScreen/forgotPasswordScreen.dart';
import 'package:ecommerce_mobile/authScreens/loginScreen/loginScreen.dart';
import 'package:ecommerce_mobile/helper_components/loading.dart';
import 'package:ecommerce_mobile/otherScreens/Home/home.dart';
import 'package:ecommerce_mobile/productScreens/prodViewScreen/prodViewScreen.dart';
import 'package:flutter/material.dart';


// MyRoutes is the funcion we pass on onGenerateRoute
MyRoutes(settings){ // it takes in settings argument which has all the information passed in the Navigator.pushNamed()
    dynamic url = settings.name; // settings.name returns the named-router-url which is passed in .pushNamed()

    if(url == "/"){ // if "/" is passed in .pushNamed()
      return MaterialPageRoute(builder: (context)=>const HomeScreen());
    }else if(url == "/login"){ // if "/login" is passed in .pushNamed()
      return MaterialPageRoute(builder: (context)=> LoginScreen());
    }else if(url == "/signUp"){ // if "/signUp" is passed in .pushNamed()
      return MaterialPageRoute(builder: (context)=> SignUpScreen());
    }else if(url == "/forgotPassword"){ // if "/forgotPassword" is passed in .pushNamed()
      return MaterialPageRoute(builder: (context)=> ForgotPassScreen());
    }else if(url == "/productView"){ // if "/productView" is passed in .pushNamed()
      return MaterialPageRoute(builder: (context)=>const ProdViewScreen());
    }else if(url == "/loading"){ // if "/loading" is passed in .pushNamed()
      return MaterialPageRoute(builder: (context)=>const LoadingScreen());
    }
}