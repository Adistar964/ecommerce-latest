
import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      style: IconButton.styleFrom(
        backgroundColor: const Color.fromARGB(104, 158, 158, 158),
        surfaceTintColor: const Color.fromARGB(104, 158, 158, 158)
      ),
      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 40),
    );
  }
}