import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
      ),

      body: Column(
        children: [
          const SizedBox(height: 10), // some spacing
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Icon(Icons.person),
          )
        ],
      ),
    );
  }
}