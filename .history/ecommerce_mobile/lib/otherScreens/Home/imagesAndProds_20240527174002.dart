import 'package:ecommerce_mobile/helper_components/productsSlider.dart';
import 'package:flutter/material.dart';

class FeaturedProductsContainer extends StatelessWidget {
  const FeaturedProductsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FeaturedProducts()
      ],
    );
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
            child: Image.network("https://www.luluhypermarket.com/cdn-cgi/image/f=auto/medias/hp-section2B-1.jpg?context=bWFzdGVyfGltYWdlc3wxODU0MDh8aW1hZ2UvanBlZ3xhR1kxTDJnMk9TOHhNVGMxT1RZMU1ERXhNVFV4T0M5b2NDMXpaV04wYVc5dU1rSXRNUzVxY0djfDI3ZmYyN2IzNzUxYzdlZWU5NzQwMDE4YmUyYWQxMDcyNDE1NDkyMGMzOWVjODdmOTUxMWVhMDQwN2UwZGQ4NWM",
             width: double.infinity, height: 300,),
          ),

          // then the carousel-slider for the featured-products
          const ProductSlider()
      ],
    );
  }
}

