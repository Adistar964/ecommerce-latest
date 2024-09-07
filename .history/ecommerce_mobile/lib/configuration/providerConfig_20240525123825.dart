

import "package:flutter/material.dart";


// creating our provider here:
class MyProvider extends ChangeNotifier {
    int count = 1;

    void increment (){
      count++;
      ChangeNotifier(); // this is like setState
      // it will re-render all widgets using this provider's values 
      // so now a new count variable will be used in all those widgets using the count variable
    }
}
