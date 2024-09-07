

import "package:flutter/material.dart";


// creating our provider here:
class MyProvider {
    int count = 1;

    get ccount => count;
}

void main(){
    MyProvider pr = MyProvider();
    print(pr.ccount);
}