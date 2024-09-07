

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Adcarousel extends StatelessWidget {
  final dynamic imageSources; // final means its value cant be changed once assigned
  const Adcarousel({ super.key, this.imageSources }); // contructor

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageSources.map((imageSrc) => 
        Image.network(imageSrc)
      ),
      options: CarouselOptions(

      )
      );
  }
}