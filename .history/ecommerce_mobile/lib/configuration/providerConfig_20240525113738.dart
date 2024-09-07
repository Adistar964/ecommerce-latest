

// import "package:flutter/material.dart";


// creating our provider here:
class MyProvider {
    int count = 1;

    addCount(){
      count++;
    }
    
}

void main(){
  var pr = MyProvider();
  pr.addCount();
  print(pr.count);
}