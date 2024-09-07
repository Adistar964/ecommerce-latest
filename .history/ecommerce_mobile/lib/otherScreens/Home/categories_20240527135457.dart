

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
        // padding: const EdgeInsets.all(8),
        children: const [
          CategoryCricle(color:Colors.blue,title:"Electronics", icon: Icons.devices,),
          CategoryCricle(color:Colors.green,title:"Groceries", icon: Icons.food_bank_rounded,),
          CategoryCricle(color:Colors.pink,title:"Decorations", icon: Icons.style_outlined,),
          CategoryCricle(color:Colors.brown,title:"Toys", icon: Icons.toys_outlined,),
          CategoryCricle(color:Colors.orange,title:"Clothings", icon: Icons.checkroom_outlined,),
          CategoryCricle(color:Colors.deepPurple,title:"Meat", icon: Icons.grass_outlined,),
          CategoryCricle(color:Colors.pinkAccent,title:"Health", icon: Icons.medical_services_outlined,),
        ],
      ),
    );
  }
}

class CategoryCricle extends StatelessWidget {
  final dynamic icon;
  final dynamic title;
  final dynamic color;
  const CategoryCricle({super.key,this.icon,this.title,this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50), // so it splash effects only the space that the the child is currently taking, not the whole thing
            onTap: (){},
            child: Ink( // wrapped with Ink instead of Container
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // completely a circle!
                color: color,
              ),
              child: Icon(icon, color: Colors.white, size: 40), // "icon" var is what we created in the top
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
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