

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
                  CircleAvatar(
                    child: Icon(Icons.account_box_sharp, size: 100),
                    radius: 20,
                  )
              ],
            ) 
        ),
      )
    );
  }
}