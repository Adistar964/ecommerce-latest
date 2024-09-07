

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdCarousel extends StatelessWidget {
  final dynamic imageSources; // final means its value cant be changed once assigned
  const AdCarousel({ super.key, this.imageSources }); // contructor

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