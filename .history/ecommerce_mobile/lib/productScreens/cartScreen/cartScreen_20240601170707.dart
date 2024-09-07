// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_mobile/configuration/cartConfig.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(179, 207, 216, 220),
      ),
      body : (Provider.of<MyProvider>(context).cart.length == 0 ? 
              emptyCart() // show this emptyCart widget if cart is empty
              : CartScreenBody()  // otherwise show this widget
              )
    );
  }

  Widget emptyCart(){
    return Center(
      child: Column(
        children : [
          const SizedBox(height: 100), // some spacing
          const Icon(
            Icons.shopping_bag,
            size:200,
            opticalSize: 100,
            color:Color.fromARGB(255, 209, 46, 78)
            ),
          const SizedBox(height: 40), // some spacing
          const Text(
            "There is nothing in your cart!",
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 168, 161, 161)
            ),
          ),
          const SizedBox(height: 40), // some spacing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(203, 129, 165, 184),
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Text(
                "Click the 'Add' button on the products to add them in the cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                // color: Color.fromARGB(255, 168, 161, 161)
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>( //anything inside COnsumer will get updates if the provider values change
      builder: (_,provider,__) => // _ and __ are params that are not needed
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20), // some spacing
          Padding( // wrapped in it to give some space from left and right
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ListView.builder(
              shrinkWrap: true, // to remove that unbounded height error
              scrollDirection: Axis.vertical, // vertical scroll feature
              // itemCount: Provider.of<MyProvider>(context).cart.length,
              itemCount: provider.cart.length,
              itemBuilder: (context, index) {
                // dynamic product = Provider.of<MyProvider>(context).cart[index];
                dynamic product = provider.cart[index];  
                product["_id"] = product["product_id"];
                return CartItem(product: product);
              },
            ),
          ),
          const SizedBox(height: 20), // some spacing
          Container(
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[100],
            ),
            child: Text("total: 455",textAlign: TextAlign.center,),
          ),
          const Divider(),
          const SizedBox(height: 20), // some spacing
          Center(
            child: ElevatedButton.icon(
              onPressed: (){},
              label: const Text("Checkout",style: TextStyle(color:Colors.green)),
              icon: Icon(Icons.shopping_cart_checkout),
              style: ElevatedButton.styleFrom(
                side: BorderSide(color:Colors.green),
                iconColor: Colors.green,
                minimumSize: Size(100, 50)
              ),
            ) 
          )
        ]
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  final dynamic product; // taking product as a param and storing it in this variable
  const CartItem({
    super.key,
    required this.product,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  // int quantityInCart = widget.product["quantity"]; 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical:8),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color:Colors.grey),
        borderRadius: BorderRadius.circular(10)
      ),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox( // image is inside sized box to give it our width and height
            width: 100,
            height: 100,
            child: Image.network(widget.product["thumbnail"]),
          ),
          SizedBox(width: 10), // some spacing
          SizedBox(
            width: 250,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product["product_name"],
                  style: TextStyle(
                    fontSize: 17
                  )
                ),
                SizedBox(height: 20), // some spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton.outlined(
                          // we will only have onPressed function enabled if the quantity is more than 1
                          // onPressed: widget.product["quantity"]!=1 ? ()=>subtractQuantity(context,widget.product,(){}) : null,
                          onPressed: ()=>subtractQuantity(context,widget.product,(){}),
                          color: Colors.blue,
                          style: IconButton.styleFrom(
                            fixedSize: Size(10, 10),
                            side: BorderSide(color: Colors.blue)
                          ),
                          icon: Icon(Icons.remove_outlined)
                        ),
                        Text(
                          "  ${widget.product["quantity"]}  ",
                          style: TextStyle(
                            fontSize: 18
                          )
                        ),
                        IconButton.outlined(
                          onPressed: ()=>addQuantity(context, widget.product, (){}),
                          color: Colors.blue,
                          style: IconButton.styleFrom(
                            fixedSize: Size(10, 10),
                            side: BorderSide(color: Colors.blue)
                          ),
                          icon: Icon(Icons.add)
                        )
                      ]
                    ),
                    Text(
                      "$currency ${(widget.product["price"]-widget.product["discountPrice"])*widget.product["quantity"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.5
                      )
                    )
                  ]
                )
              ]
            ),
          )
        ]
      )
    );
  }
}