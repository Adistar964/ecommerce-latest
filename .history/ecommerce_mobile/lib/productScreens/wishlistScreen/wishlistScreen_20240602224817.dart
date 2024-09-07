import 'package:ecommerce_mobile/configuration/cartConfig.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/configuration/wishlistConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Your wishlist"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20), // some spacing
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Add Wishlist To Cart", style: TextStyle(fontSize: 18)) 
              ),
            ),
            const AllProducts(),
          ],
        ),
      ),
    );
  }
}

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    dynamic products = context.watch<MyProvider>().wishlist;

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
      padding: const EdgeInsets.all(8),
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
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  dynamic cart = context.read<MyProvider>().cart;
                  if( quantityInCart(product, cart) == 0){ // if not there in cart
                    addToCart(context, product);
                  }else{ // if already present in cart, then just add its quantity in the cart
                    addQuantity(context, product);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart!"))
                  );
                  HapticFeedback.selectionClick(); // then some vibration effect
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.lightBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  iconColor: Colors.lightBlue
                ),
                label: const Text("Add to Cart", style: TextStyle(color: Colors.lightBlue)),
              ),
              ElevatedButton.icon(
                onPressed: ()=>toggleFav(context, product, true), // that true is simply passed and is not needed as we r not using the likeButton here
                icon: const Icon(Icons.delete_outline_rounded),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.lightBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  iconColor: Colors.lightBlue
                ),
                label: const Text("Remove", style: TextStyle(color: Colors.lightBlue)),
              ),
            ],
          )
        ],
      ),
    );
  }
}