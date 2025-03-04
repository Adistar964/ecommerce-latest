import 'package:ecommerce_mobile/configuration/cartConfig.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/configuration/wishlistConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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

      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20), // some spacing
            AllProducts(),
          ],
        ),
      ),
    
      bottomNavigationBar: const BottomMoveButton(),
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

class BottomMoveButton extends StatelessWidget {
  const BottomMoveButton({super.key});


  // will ask the user to confirm if they really want to do the moving
  confirmMoveToCart(context){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
            title: const Text("Move to Cart?"),
            content: const Text(
              "Do you want to proceed moving every wishlist-item to cart?\n\nsome items wont be added if they reach maximum quantity in cart",
              style: TextStyle(
                fontSize: 16
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  foregroundColor: Colors.red,
                ),
                child: const Text("Cancel"),
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  await moveWishlistToCart(context);
                  Navigator.of(context).pop(); // then remove this dialogScreen
                },
                icon: const Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
                label: const Text("Proceed"),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  foregroundColor: Colors.blue,
                ),
              )
            ],
        );
      }
    
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 30,
      color: Colors.grey[50],
      child: TextButton.icon(
      onPressed: () => confirmMoveToCart(context),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        foregroundColor: Colors.white,
        // side: const BorderSide(color:Colors.indigo)
        backgroundColor: Colors.indigo
      ),
      icon: const Icon(Icons.arrow_forward_rounded),
      iconAlignment: IconAlignment.end,
      label: const Text("Move Wishlist To Cart", style: TextStyle(fontSize: 18)) 
    ),
    );
  }
}