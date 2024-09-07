
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatelessWidget {
  final dynamic products; // list of products to add in the carousel-slider
  const ProductSlider({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    print(products);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.5,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          height: 300,
          initialPage: 1,
        ),
        items: products.map<Widget>((product) => 
            ProductCard(product: product)
        ).toList()
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final dynamic product; // product param will have all info like title,price,etc..
  const ProductCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card.outlined(
          color: Colors.white,
          elevation: 2,
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.network(product.thumbnail, 
                  fit: BoxFit.fill),
                ),
                const SizedBox(height: 10),
                Text(product.title, style: const TextStyle(
                  fontWeight: FontWeight.bold
                ))
              ],
          ),
        ),
      ),
    );
  }
}