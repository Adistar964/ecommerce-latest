

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatelessWidget {
  final dynamic images; 
  const ProductImageSlider({super.key,this.images}); // takes images(and key) as a parameter

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: images.map<Widget>( (imageSrc) =>
              Image.network(imageSrc, fit: BoxFit.fill)
          ).toList(),
          options: CarouselOptions(
            autoPlay: true,
            height: 400,
            viewportFraction: 1,
            padEnds: false
          )
        )
      ],
    );
  }
}