

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      // we will only have a body
      body: const SafeArea(
        child: Center(
            child: Column(
              children: [
                  SizedBox(height: 50), // leaving some space
                  Icon(Icons.lock, size: 120),
                  Padding(
                    padding: EdgeInsets.only( top:20, right:41, left:41 ),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                    
                      ),
                    ),
                  )
              ],
            ) 
        ),
      )
    );
  }
}