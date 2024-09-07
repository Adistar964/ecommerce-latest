
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()=>Navigator.of(context).pop(),
      style: IconButton.styleFrom(
        backgroundColor: Color.fromARGB(181, 255, 250, 250)
      ),
      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 27),
    );
  }
}