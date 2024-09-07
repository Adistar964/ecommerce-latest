
import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      style: IconButton.styleFrom(
        backgroundColor: const Color.grey,
        surfaceTintColor: const Color.grey
      ),
      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 40),
    );
  }
}