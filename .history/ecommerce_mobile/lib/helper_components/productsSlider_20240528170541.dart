
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
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
          height: 420,
          initialPage: 1,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 20),
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
        child: Stack(
          children: [
            Card.outlined(
              color: Colors.grey[100],
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.network(product["thumbnail"], fit: BoxFit.fill),
                      ),
                      const SizedBox(height: 10), // leaving some space
                      Text(
                        product["title"], 
                        style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 17
                        )
                      ),
                      const SizedBox(height: 16), // leaving some space
                      ( // only show discounted price if there was a dicountPrice assigned to the product
                      product["disocuntPrice"] != 0 ?
                      Text(
                        "$currency ${product["price"]}", // price is actual price minus any discount in it
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          decoration: TextDecoration.lineThrough
                        ), 
                      )
                      : const Text("")),
                      const SizedBox(height: 6), // leaving some space
                      Text(
                        "$currency ${product["price"] - product["discountPrice"]}", // price is actual price minus any discount in it
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ), 
                      ),
                      const SizedBox(height: 10), // leaving some space
                      MaterialButton(
                        onPressed: (){},
                        padding: const EdgeInsets.all(8),
                        color : Colors.lightBlue,
                        textColor: Colors.white,
                        minWidth: double.maxFinite,
                        child: const Text("Add", style: TextStyle(fontSize:20)),
                      )
                    ],
                ),
              ),
            ),

          // this second widget(iconButton) will be stacked on top of the previous first widget(card.outlined)
          Positioned( // Positioned is for giving any position to elements inside it
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: (){},
              // color: Colors.grey[600],
              style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[100],
              ),
              icon: const Icon(Icons.favorite_outline_rounded, color:Colors.black),
              padding: const EdgeInsets.all(10),
            ),
          )
          ]
        ),
      ),
    );
  }
}