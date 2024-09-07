

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // we will only have a body
      body: const Center(
          child: Column(
            children: [
                Text("LOGIN")
            ],
          ) 
      )
    );
  }
}