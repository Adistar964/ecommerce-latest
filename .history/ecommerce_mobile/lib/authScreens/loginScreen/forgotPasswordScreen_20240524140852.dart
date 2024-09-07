
import 'package:flutter/material.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password", style: TextStyle(color:Colors.blue[100]) ),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
    );
  }
}