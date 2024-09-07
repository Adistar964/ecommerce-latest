

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // for a better loading ui
// view for more: https://pub.dev/documentation/flutter_spinkit/latest/

// this will show loading screen
// it will not be a seperate screen, but just a dialog which takes up the entire screen by hiding background-Screen 
showLoading(context){
          showDialog(
            context: context,
            barrierColor: Colors.white,
            builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFoldingCube( // custom loading-indicator from the spin-kit package 
                  color: Colors.blue[300],
                  size: 80
                ),
                const SizedBox(height: 40),
                const Text("loading", style: TextStyle( fontSize:18,color: Color.fromARGB(255, 89, 88, 88) ) )
              ]
            )
          ));
}