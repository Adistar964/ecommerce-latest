

import 'package:ecommerce_mobile/helper_components/productsSlider.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  final dynamic products;
  const AllProducts({
    super.key,
    required this.products
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder( // we will not use GridView.count, but GridView.builder, therefore it is a bit different
      // instead of simply giving crossAxisCount: numer_of_items, we have to do it like below:
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      // and now the rest is same as any other builder
      itemCount: products.length,
      itemBuilder: (context,index) => ProductCard(product: products[index]),
    );
  }
}