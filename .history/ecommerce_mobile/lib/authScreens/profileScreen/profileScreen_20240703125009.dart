import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // first child is that top card of our profile, and the other child are the actions
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200]
            ),
            child: Column(
              children: [
                const SizedBox(height: 30), // some spacing
                Container( // then the profile icon
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    shape: BoxShape.circle,
                    color: Colors.black
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.person,size: 100, color: Colors.black,),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // some spacing
                Text(
                  FirebaseAuth.instance.currentUser?.email  ??  "",  // to resolve: The argument type 'String?' can't be assigned to the parameter type 'String
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(height: 20), // some spacing
              ],
            ),
          ),
        ],
      ),
    );
  }
}