

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

// indicators for our carousel created above
class CarouselIndicators extends StatelessWidget {
  final dynamic controller;
  final dynamic numberOfIndicators;
  const CarouselIndicators({super.key,this.controller,this.numberOfIndicators});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator( // from package "smooth_page_indicator"
      controller: controller,
      count: numberOfIndicators,
      effect: const ExpandingDotsEffect(), // look more in their webpage for different effects they have
      );
  }
}