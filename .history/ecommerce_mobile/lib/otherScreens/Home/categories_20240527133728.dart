

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
        padding: const EdgeInsets.all(8),
        children: const [
          CategoryCricle(title:"Electronics", icon: Icons.devices,),
          CategoryCricle(title:"Groceries", icon: Icons.food_bank_rounded,),
          CategoryCricle(title:"Decorations", icon: Icons.style_outlined,),
          CategoryCricle(title:"Toys", icon: Icons.toys_outlined,),
          CategoryCricle(title:"Clothings", icon: Icons.checkroom_outlined,),
          CategoryCricle(title:"Meat and Poultry", icon: Icons.grass_outlined,),
          CategoryCricle(title:"Health and beauty", icon: Icons.medical_services_outlined,),
        ],
      ),
    );
  }
}

class CategoryCricle extends StatelessWidget {
  final dynamic icon;
  final dynamic title;
  const CategoryCricle({super.key,this.icon,this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // completely a circle!
              color: Colors.green,
            ),
            child: Icon(this.icon, color: Colors.white, size: 40), // "icon" var is what we created in the top
          ),
          const SizedBox(height: 6),
          Text(
            "Snacks",
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}