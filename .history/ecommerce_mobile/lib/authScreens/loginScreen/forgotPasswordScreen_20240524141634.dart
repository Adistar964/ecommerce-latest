
import 'package:ecommerce_mobile/authScreens/loginScreen/textField.dart';
import 'package:flutter/material.dart';

class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({super.key});

  final emailController = TextEditingController(); // this will be assigned to our email-text field to access it

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),

      body: Padding(
        padding: const EdgeInsets.only( top:20, right:50, left:50 ),
        child: Column(
          children: [
            const Text("Enter your email" , style: TextStyle(fontSize:23) ),
            // now the MyTextField widget which we created
            MyTextField( label: "Email", controller: emailController, obscureText: false)
          ]
          ),
      ),

    );
  }
}