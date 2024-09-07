
import 'package:flutter/material.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),

      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 20), // leaving some space
            Text("Enter your email" , style: TextStyle(fontSize:30) ),
          ]
          ),
      ),

    );
  }
}