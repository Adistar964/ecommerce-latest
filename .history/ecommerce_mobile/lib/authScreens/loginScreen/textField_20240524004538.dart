

import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  // we will pass in our params too
  final obscureText;
  final label;
  final controller; // for gaining the access to input field's value
  const LoginTextField( { super.key, this.controller, this.label, this.obscureText });

  @override
  Widget build(BuildContext context) {
    return TextField( // our input field
                  obscureText: obscureText, // if true, will show * while typing, which is needed  in a password field
                  controller: controller, // controller helps gain access to input field's value
                  style: const TextStyle( fontSize: 17 ), // this is for the styling of the text iniside the input 
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder( borderRadius: BorderRadius.circular(10) ),
                      label: Text("  $label"),
                      labelStyle: const TextStyle( fontSize: 17.6 ),
                      filled: true, // we will enable this so that we can fill up a color for the input (basically its bg)
                      fillColor: Colors.white,
                  )
                );
  }
}