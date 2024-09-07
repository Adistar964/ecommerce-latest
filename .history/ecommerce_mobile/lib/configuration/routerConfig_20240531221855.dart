import 'package:ecommerce_mobile/authScreens/SignUpScreen/signUpScreen.dart';
import 'package:ecommerce_mobile/authScreens/loginScreen/forgotPasswordScreen.dart';
import 'package:ecommerce_mobile/authScreens/loginScreen/loginScreen.dart';
import 'package:ecommerce_mobile/helper_components/loading.dart';
import 'package:ecommerce_mobile/otherScreens/Home/home.dart';
import 'package:ecommerce_mobile/otherScreens/mainScreen.dart';
import 'package:ecommerce_mobile/productScreens/cartScreen/cartScreen.dart';
import 'package:ecommerce_mobile/productScreens/prodViewScreen/prodViewScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


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
      dynamic arguments = settings.arguments; // the arguments passed with the url in .pushNamed() 
      // => basically passing data while passing to this screen
      var product = arguments["product"]; // getting product from those arguments
      return MaterialPageRoute(builder: (context)=> ProdViewScreen(product:product));
    }else if(url == "/cart"){ // if "/cartScreen" is passed in .pushNamed()
      return MaterialPageRoute(builder: (context)=>const CartScreen());
    }else if(url == "/loading"){ // if "/loading" is passed in .pushNamed()
      return MaterialPageRoute(builder: (context)=>const LoadingScreen());
    }
}


dynamic rootNavigatorKey = GlobalKey<NavigatorState>(); // will be used in our router below
dynamic homeNavigatorKey = GlobalKey<NavigatorState>(); // for maintaining state in our home-screen branch
dynamic cartNavigatorKey = GlobalKey<NavigatorState>(); // for maintaining state in our cart-screen branch

GoRouter MyRouter = GoRouter(
  navigatorKey: rootNavigatorKey, // will be used to maintain the routing and to know which page we currently are on
  initialLocation: FirebaseAuth.instance.currentUser == null ? "/login" : "/home", // take us to login page if the user is not signed in, otherwise to home page
  routes: [
    // we will first have login/register screens which only require simple route like below:
    // GoRoute(
    //   path:"/login",
    //   builder: (context, state) => LoginScreen(),
    // ),
    // GoRoute(
    //   path:"/signUp",
    //   builder: (context, state) => SignUpScreen(),
    // ),

    // then we will have our complex pages that require deep-linking and persistent bottomNavBar
    // deep-linking example: our home screen will have productView screen nested inside
    // state-preservance example: when we change from profile/settings screen to some other screen and then come back, we will still see the same screen in the same state instead of being re-rendered
    // this can be helpful, cuz user can come back and continue from where he left off in the settings page.
    //Now when we combine them:
    //User in home screen clicks on some product, then prodView screen pops up
    // then user goes to cart screen for doing something
    // now from the bottomNavBar, when user presses home button, he doesnt land back to homeScreen, but instead in the prodView screen where he left off and as prodView is a subScreen from homeScreen
    StatefulShellRoute.indexedStack(
      // builder will return the main wrapper screen which shows all the screens and routes
      builder: (context, state, navigationShell) => MainWrapperScreen(navigationShell: navigationShell), // just pass navigationShell which will handle showing different pages in the wrapper's Scaffold body
      branches: [
        // first will be home-branch:
        StatefulShellBranch(
          navigatorKey: homeNavigatorKey, // the one we created above which will help in maintaining the state even if we leave this screen
          routes: [
          // main route/ parent route in the branch
          GoRoute(
            path:"/home",
            builder: (context,state)=>HomeScreen(key: state.pageKey), // key passed will be used with all the widgets to maintain their state
            // sub-screens inside home-screen/parent-route
            routes: [
              GoRoute(path: "/productView", builder: (context, state) => LoginScreen(key: state.pageKey))
            ]
          )
        ]),
        // this will be our cart-screen branch
        StatefulShellBranch(
          navigatorKey: cartNavigatorKey,
          routes: [
            // main-route
            GoRoute(path: "/cart",builder: (context, state) => CartScreen(key: state.pageKey))
          ]
        )
      ]
    )
  ]
); 