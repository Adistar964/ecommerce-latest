

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdCarousel extends StatelessWidget {
  const AdCarousel({ super.key }); // contructor

  @override
  Widget build(BuildContext context) {

    // now getting carousel-images from the provider's variable "homeData" which got its data from the backend
    List imageSources = context.read<MyProvider>().homeData["carousel images"];

    return Padding(
      padding: const EdgeInsets.all(10),
      child: CarouselSlider(
        items: imageSources.map((imageSrc) => 
          Padding(
            padding: const EdgeInsets.all(6),
            child: ClipRRect( // for rounded borders
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageSrc, fit: BoxFit.fill) // BoxFit.fill will make sure it takes entire provided height and width
              ),
          ) 
        ).toList(), // .toList() stores all the returned value from .map to a list
        options: CarouselOptions(
            viewportFraction: 1, // show the slide completely
            // height: 170,
            autoPlay: true,
            autoPlayInterval: const Duration( seconds: 8 ),
            autoPlayCurve: Curves.fastEaseInToSlowEaseOut, // animation with how the slides move
        )
        ),
    );
  }
}