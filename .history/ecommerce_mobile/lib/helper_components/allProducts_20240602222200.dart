

import 'package:ecommerce_mobile/configuration/constants.dart';
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
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), // because we already have singleChildScrollView at the toplevel
      itemCount: products?.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        dynamic product = products[index];
        product["title"] = product["product_name"]; // because we use "title" in WishlistItemCard 
        return WishlistItemCard(product: product);
      }
    );
  }
}

class WishlistItemCard extends StatelessWidget {
  final dynamic product;
  const WishlistItemCard({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Image.network(product["thumbnail"], fit: BoxFit.fill,)
              ),
              const SizedBox(width: 10), // some spacing
              Column(
                children: [
                  SizedBox(
                    width: 230,
                    height: 60,
                    child: Text(
                      product["title"],
                      style: const TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 25), // some spacing
                  Text(
                    "$currency ${product["price"]-product["discountPrice"]}", // its actual price
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                    textAlign: TextAlign.left,
                  )
                ]
              )
            ],
          ),

          // now the footer:
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: (){},
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text("Add to Cart"),
              )
            ],
          )
        ],
      ),
    );
  }
}