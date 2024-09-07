

import 'package:flutter/material.dart';

class CategoryCirclesContainer extends StatelessWidget {
  const CategoryCirclesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal, // horizontal scroll
        children: const [
          CategoryCricle(),
          CategoryCricle(),
          CategoryCricle(),
          CategoryCricle(),
          CategoryCricle(),
          CategoryCricle(),
          CategoryCricle(),
          CategoryCricle(),
        ],
      ),
    );
  }
}

class CategoryCricle extends StatelessWidget {
  const CategoryCricle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          color: Colors.green,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), // completely a circle!
          ),
          child: const Icon(Icons.food_bank_rounded, color: Colors.white),
        ),
      ],
    );
  }
}