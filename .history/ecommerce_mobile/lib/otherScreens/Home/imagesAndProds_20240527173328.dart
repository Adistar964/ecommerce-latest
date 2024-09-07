import 'package:ecommerce_mobile/helper_components/productsSlider.dart';
import 'package:flutter/material.dart';

class FeaturedProductsContainer extends StatelessWidget {
  const FeaturedProductsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class FeaturedProducts extends StatelessWidget {
  final dynamic featuredProductsImage;
  final dynamic products;
  const FeaturedProducts({super.key,this.featuredProductsImage,this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // First the header image(image describing the featured products)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(featuredProductsImage, width: double.infinity,height: 170,),
          ),

          // then the carousel-slider for the featured-products
          const ProductSlider()
      ],
    );
  }
}

