

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatelessWidget {
  final dynamic images; 
  const ProductImageSlider({super.key,this.images}); // takes images(and key) as a parameter

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map<Widget>( (imageSrc) =>
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: Image.network(imageSrc, fit: BoxFit.fill, width: double.maxFinite)
            )
      ).toList(),
      options: CarouselOptions(
        // autoPlay: true,
        height: 350,
        viewportFraction: 1,
        
      )
    );
  }
}