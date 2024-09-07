

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

    return CarouselSlider(
      items: imageSources.map((imageSrc) => 
        Image.network(imageSrc)
      ).toList(), // .toList() stores all the returned value from .map to a list
      options: CarouselOptions(

      )
      );
  }
}