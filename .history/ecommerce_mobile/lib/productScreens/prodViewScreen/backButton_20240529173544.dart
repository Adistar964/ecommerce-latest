
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      style: IconButton.styleFrom(
        backgroundColor: Colors.grey,
        surfaceTintColor: Colors.grey
      ),
      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 40),
    );
  }
}