

import 'package:flutter/material.dart';

class CategoryCirclesContainer extends StatelessWidget {
  const CategoryCirclesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // if any widget gives unbounded error, then one solution is to always wrap it inside a sizedbox with a definite height and width
      width: 1000,
      height: 200,
      child: ListView(
        shrinkWrap: true, // to get rid of overflow error
        scrollDirection: Axis.horizontal, // horizontal scroll
        children: const [
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
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), // completely a circle!
            color: Colors.green,
          ),
          child: const Icon(Icons.food_bank_rounded, color: Colors.white),
        ),
      ],
    );
  }
}