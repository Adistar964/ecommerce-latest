// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_mobile/configuration/cartConfig.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
      if(context.watch<MyProvider>().cart.length == 0){
        return EmptyCartBody(); //if nothing in cart!
      }else{
        return CartScreenBody(); // if cart not empty
      }
  }
}



class EmptyCartBody extends StatelessWidget {
  const EmptyCartBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(179, 207, 216, 220),
      ),

      body: Center(
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
      ),
    );
  }
}

class CartScreenBody extends StatefulWidget {
  const CartScreenBody({
    super.key,
  });

  @override
  State<CartScreenBody> createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  int totalAmount = 0; // total amount for the whole cart

  @override
  void initState() {
    super.initState();
    updateTotalAmount(); // updates the total amount
  }

  // gets the total worth of the cart
  updateTotalAmount(){
    dynamic total = 0; // initially
    for(var item in context.read<MyProvider>().cart ){
        dynamic price_of_this_item = item["price"] - item["discountPrice"];
        dynamic total_price_of_item = price_of_this_item * item["quantity"];
        total+=total_price_of_item;
    } 
    setState(() {
      totalAmount = total;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(179, 207, 216, 220),
      ),
      body: Consumer<MyProvider>( //anything inside COnsumer will get updates if the provider values change
        builder: (_,provider,__) => // _ and __ are params that are not needed
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20), // some spacing
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 100,vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    "total: 455",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true, // to remove that unbounded height error
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 14),
                itemCount: provider.cart.length,
                itemBuilder: (context, index) {
                  // dynamic product = Provider.of<MyProvider>(context).cart[index];
                  dynamic product = provider.cart[index];  
                  product["_id"] = product["product_id"];
                  return CartItem(product: product,updateTotalAmount: updateTotalAmount);
                },
              ),
              // const Divider(),
              const SizedBox(height: 100), // some spacing
            ]
          ),
        ),
      ),

      bottomNavigationBar: BottomProceedButton(totalAmount: totalAmount),
    );
  }
}

class CartItem extends StatelessWidget {
  final dynamic product; // taking product as a param and storing it in this variable
  final dynamic updateTotalAmount; // updateTotalAmount is called everytime the cart changes as the total amount also changes
  const CartItem({
    super.key,
    required this.product,
    required this.updateTotalAmount
  });

  // int quantityInCart = widget.product["quantity"]; 
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane( // endActionPane slides from the right
        motion: ScrollMotion(), // behaviour when sliding
        children: [ // slideable-actions
          Expanded( // for taking whole width
            child: InkWell(
              onTap: ()=>removeFromCart(context,product,()=>updateTotalAmount),
              child: Container(
                height: double.maxFinite,
                // width: double.maxFinite, // not working, therefore Expanded used
                padding: EdgeInsets.symmetric(vertical:8),
                margin: EdgeInsets.only(bottom:10),
                color: Colors.red,
                child: Center(child: Icon(Icons.delete,color: Colors.white,size: 30,)),
              ),
            ),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical:8),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color:Colors.grey),
          borderRadius: BorderRadius.only(
            // only left side will have a rounded border
            // right side will be linear straight border for the slideable widget
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )
        ),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox( // image is inside sized box to give it our width and height
              width: 100,
              height: 100,
              child: Image.network(product["thumbnail"]),
            ),
            SizedBox(width: 10), // some spacing
            SizedBox(
              width: 250,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product["product_name"],
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
                            onPressed: ()=>subtractQuantity(context,product,()=>updateTotalAmount()), // updating totalAmount after changing the quantity
                            color: Colors.blue,
                            style: IconButton.styleFrom(
                              fixedSize: Size(10, 10),
                              side: BorderSide(color: Colors.blue)
                            ),
                            icon: Icon(Icons.remove_outlined)
                          ),
                          Text(
                            "  ${product["quantity"]}  ",
                            style: TextStyle(
                              fontSize: 18
                            )
                          ),
                          IconButton.outlined(
                            onPressed: ()=>addQuantity(context,product,()=>updateTotalAmount()), // updating totalAmount after changing the quantity
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
                        "$currency ${(product["price"]-product["discountPrice"])*product["quantity"]}",
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
      ),
    );
  }
}

class BottomProceedButton extends StatelessWidget {
  final int? totalAmount;
  const BottomProceedButton({
    super.key,
    this.totalAmount
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical:15),
      color: Color.fromARGB(255, 247, 238, 238),
      elevation: 5,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          "Checkout $currency $totalAmount",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      ) 
    );
  }
}