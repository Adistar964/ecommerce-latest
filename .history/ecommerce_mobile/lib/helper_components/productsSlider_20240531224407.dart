import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_mobile/configuration/cartConfig.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/configuration/wishlistConfig.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

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
          // enlargeCenterPage: true,
          enableInfiniteScroll: false,
          height: 420,
          initialPage: 1,
          // autoPlay: true,
          // autoPlayAnimationDuration: const Duration(seconds: 20),
        ),
        items: products.map<Widget>((product) => 
            ProductCard(product: product)
        ).toList()
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final dynamic product; // product param will have all info like title,price,etc..
  const ProductCard({super.key, this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int productCartQuantity = 0; // we will first assume the product is not there in cart
  dynamic isFav = false; // we will first assume the product is not in the wishlist

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_){ // first let widgets load
    if(context.mounted){ // first let everything get loaded (double check)
        //callAssignProductCartQuantity() will check if the product is in the cart and assigns it a proper quantity if it exists, otherwise assigns product a quantity of 0
        callAssignProductCartQuantity(); // this function simply calls assignCartQuantity function with appropriate parameters
        // callAssignProductCartQuantity is basically qssignCartQuantity function, but shortened code
        // then checkFav() will check if the product is in the wishlist and then updates isFav variable accordingly using wishlistExistsCallback and wishlistAbsentCallback
        callCheckFav(); // this function simply calls checkFav function with appropriate parameters
        // callCheckFav is basically checkFav function, but shortened code
    }
    });

    super.initState(); // parent initState must always run atlast!
  }


  // these 2 call functions simply calls checkFav/assignProductQuantity function with appropriate parameters
  // these 2 call functions were made to reduce code while calling checkFav,assignProductQuantity function so that we dont write these params over and over again
  callAssignProductCartQuantity(){
    assignProductCartQuantity(
      context,
      product:widget.product, // widget.variable is used to get the variable defined in the original statefulClass
      existsInCart_callback:(item){setState(() => productCartQuantity = item["quantity"]);}, // if it exists, update the productCartQuantity variable created above
      absentInCart_callback:() => setState(() => productCartQuantity = 0), // if it is absent, update the productCartQuantity variable created above to zero
    );
  }

  callCheckFav(){
      checkFav(context,
      product: widget.product, // widget.variable is used to get the variable defined in the original statefulClass
      wishlistExistsCallback: () => setState(()=>isFav=true), // will run if the product is present in wishlist
      wishlistAbsentCallback: () => setState(()=>isFav=false), // will run if the product is absent in wishlist
      ); 
  }

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // card-header
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: ()=>GoRouter.of(context).pushNamed("productView"),
                          // onTap: () => Navigator.of(context).pushNamed(
                          //   "/productView", arguments: { "product":widget.product } // we r passing an argument here
                          //   ).then( (_){callCheckFav();callAssignProductCartQuantity();} ), 
// doing this would make sure that this screen would run these functions again when u come back to this screen,
// as we need to run checkFav and assignProductQuantity to reload changes in this page as some other page might have changed some values like cart or wishlist
                          child: Image.network(widget.product["thumbnail"], fit: BoxFit.fill)
                          ),
                      ),

                      // card-body
                      Column(
                        children: [
                      const SizedBox(height: 10), // leaving some space
                      SizedBox(
                        height: 20, // for the purpose of giving uniform height to title-spaces regardless of how long the titles are
                        child: Text(
                          widget.product["title"], 
                          style: const TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 17)
                        ),
                      ),
                      const SizedBox(height: 16), // leaving some space
                      ( // only show discounted price if there was a dicountPrice assigned to the product
                      widget.product["disocuntPrice"] != 0 ?
                      Text(
                        "$currency ${widget.product["price"]}", // price is actual price minus any discount in it
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          decoration: TextDecoration.lineThrough
                        ), 
                      )
                      : const Text("")),
                      const SizedBox(height: 6), // leaving some space
                      Text(
                        "$currency ${widget.product["price"] - widget.product["discountPrice"]}", // price is actual price minus any discount in it
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ), 
                      ),
                      const SizedBox(height: 10), // leaving some space
                        ],
                      ),

                      // card-footer
                      (productCartQuantity == 0 ? // if not there in cart 
                      MaterialButton(
                        onPressed: ()=>addToCart(context, widget.product, callAssignProductCartQuantity),
                        // onPressed: () => print(isFav),
                        // widget.product refers to the product variable we created in the main StatefulWidget-class
                        padding: const EdgeInsets.all(8),
                        color : Colors.lightBlue,
                        textColor: Colors.white,
                        minWidth: double.maxFinite,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                        child: const Text("Add", style: TextStyle(fontSize:18)),
                      )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: ()=>subtractQuantity(context, widget.product, callAssignProductCartQuantity),
                          padding: const EdgeInsets.all(8),
                          color : Colors.lightBlue,
                          textColor: Colors.white,
                          // shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                          child: const Icon(Icons.remove, size:25 ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right:4, left:4, top:6, bottom:4),
                          decoration: BoxDecoration(
                            border: Border.all( color: Colors.grey )
                          ),
                          child: Center(
                            child: Text(
                              "$productCartQuantity",
                              style: const TextStyle(
                                fontSize: 20, 
                                color: Colors.black,
                                backgroundColor: Colors.white,
                                ),
                              ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: ()=>addQuantity(context, widget.product, callAssignProductCartQuantity),
                          padding: const EdgeInsets.all(8),
                          color : Colors.lightBlue,
                          textColor: Colors.white,
                          // shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                          child: const Icon(Icons.add, size:25 ),
                        ),
                      )
                      ],
                    )
                    )
                    ],
                ),
              ),
            ),

          // this second widget(iconButton) will be stacked on top of the previous first widget(card.outlined)
          Positioned( // Positioned is for giving any position to elements inside it
            top: 0,
            right: 0,
            child: 
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(), // defining a border for our button
                  borderRadius: BorderRadius.circular(30), // any large radius value can make the border circular
                  color: Colors.white,
                ),
                child: LikeButton( // from "like_button" package which gives cool animation for like button
                  isLiked: isFav,  // to inform it when the button is liked
                  size: 40, // button size
                  onTap: (isLiked)=>toggleFav(context, widget.product, callCheckFav,isLiked),
                  likeBuilder:(isLiked)=> // likeBuilder takes your custom icon
                  Icon(Icons.favorite_outline_rounded,color: isLiked ? Colors.pink :Colors.grey)
                  // ),
                ),
              )
            ),
          ]
        ),
      ),
    );
  }
}