

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      // we will only have a body
      body: SafeArea(
        child: Center(
            child: Column(
              children: [
                  const SizedBox(height: 50), // leaving some space
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child : const Icon(Icons.account_box_sharp, size: 100)
                  )
              ],
            ) 
        ),
      )
    );
  }
}