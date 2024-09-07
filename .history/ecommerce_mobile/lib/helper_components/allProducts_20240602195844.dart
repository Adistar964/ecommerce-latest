

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
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.network(product["thumbnail"], fit: BoxFit.fill,)
          ),
          const SizedBox(width: 10), // some spacing
          Column(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  product["title"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25), // some spacing
              MaterialButton(
                onPressed: (){},
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text("Add", style: TextStyle(fontSize: 16)),
              )
            ]
          )
        ],
      ),
    );
  }
}