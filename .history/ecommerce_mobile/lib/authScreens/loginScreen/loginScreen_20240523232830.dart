

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // we will only have a body
      body: SafeArea(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.only( top:20, right:40, left:40 ),
              child: Column(
                children: [
                    const SizedBox(height: 50), // leaving some space
                    const Icon(Icons.lock, size: 120),
                    const SizedBox(height: 40), // leaving some space
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.orange,
                          contentPadding: const EdgeInsets.all(5),
                          border: OutlineInputBorder( borderRadius: BorderRadius.circular(10) ),
                          label: const Text("  Email"),
                          hintText: "example@gmail.com"
                      ),
                    )
                ],
              ),
            ) 
        ),
      )
    );
  }
}