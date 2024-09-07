

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImageSlider extends StatelessWidget {
  final dynamic images; 
  final dynamic changeActiveIdxFunction; 
  const ProductImageSlider({super.key,this.images,this.changeActiveIdxFunction}); 
  // takes images and changeActiveIdxFunction(and key) as parameters
  // changeActiveIdxFunction will be run when the slide changes so that we can keep track of the activeIndex of this carousel

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
        autoPlay: true,
        height: 350,
        viewportFraction: 1,
        onPageChanged: (index,reason) => changeActiveIdxFunction(index)        
      )
      
    );
  }
}

// indicators for our carousel created above
class CarouselIndicators extends StatelessWidget {
  final dynamic activeCarouselIndex;
  final dynamic numberOfIndicators;
  const CarouselIndicators({super.key,this.activeCarouselIndex,this.numberOfIndicators});

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator ( // from package "smooth_page_indicator"
      activeIndex: activeCarouselIndex, // its active index will be the current active index of the carousel
      count: numberOfIndicators,
      effect: const ExpandingDotsEffect(), // look more in their webpage for different effects they have
      );
  }
}