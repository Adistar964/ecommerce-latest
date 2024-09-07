
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatelessWidget {
  final dynamic products; // list of products to add in the carousel-slider
  const ProductSlider({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.5,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          height: 300,
          initialPage: 2,
        ),
        items: [1,2,3].map((product) => 
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
                  child: Image.network("https://images.unsplash.com/photo-1608788524926-41b5181b89a2?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=220&ixid=MnwxfDB8MXxyYW5kb218MHx8SXNsYW5kfHx8fHx8MTcxNDQxMTYyMA&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=220", 
                  fit: BoxFit.fill),
                ),
                const SizedBox(height: 10),
                const Text("Card title", style:TextStyle(
                  fontWeight: FontWeight.bold
                ))
              ],
          ),
        ),
      ),
    );
  }
}