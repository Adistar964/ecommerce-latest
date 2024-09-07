import 'package:ecommerce_mobile/configuration/cartConfig.dart';
import 'package:ecommerce_mobile/configuration/constants.dart';
import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/configuration/wishlistConfig.dart';
import 'package:ecommerce_mobile/helper_components/bottomNavbar.dart';
import 'package:ecommerce_mobile/productScreens/prodViewScreen/carouselTopButtons.dart';
import 'package:ecommerce_mobile/productScreens/prodViewScreen/imageSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProdViewScreen extends StatefulWidget {
  final dynamic product;
  const ProdViewScreen({super.key,this.product});

  @override
  State<ProdViewScreen> createState() => _ProdViewScreenState();
}

class _ProdViewScreenState extends State<ProdViewScreen> {
  int activeCarouselIndex = 0; // initally carousel's active slide will be the first one
  // above is to keep track of active index of the carousel so that the indicator can display it accurately

  // once the carousel changes slides and hence also active index, we will change our activeCarouselIndex using setState
  setActiveCarouselIndex(index){
    setState(() {
      activeCarouselIndex = index;
    });
  }  

  bool isFav = false; // true, if product there in wishlist, otherwise false
  int productCartQuantity = 0; // this shows the quantity of this item in the cart (zero implies that it is not there in the cart)

  @override
  void initState() {

    if(context.mounted){ // first let everything get loaded
        //callAssignProductCartQuantity() will check if the product is in the cart and assigns it a proper quantity if it exists, otherwise assigns product a quantity of 0
        callAssignProductCartQuantity(); // this function simply calls assignCartQuantity function with appropriate parameters
        // callAssignProductCartQuantity is basically qssignCartQuantity function, but shortened code
        // then checkFav() will check if the product is in the wishlist and then updates isFav variable accordingly using wishlistExistsCallback and wishlistAbsentCallback
        callCheckFav(); // this function simply calls checkFav function with appropriate parameters
        // callCheckFav is basically checkFav function, but shortened code
    }

    super.initState(); // parent initState must always run atlast!
  }


  // these 2 call functions simply calls checkFav/assignProductQuantity function with appropriate parameters
  // these 2 call functions were made to reduce code while calling checkFav,assignProductQuantity function so that we dont write these params over and over again
  callAssignProductCartQuantity(){
    assignProductCartQuantity(
      context,
      product:widget.product, // widget.variable is used to get the variable defined in the original statefulClass
      existsInCart_callback:(item)=> setState(() => productCartQuantity = item["quantity"]), // if it exists, update the productCartQuantity variable created above
      absentInCart_callback:()=> setState(() => productCartQuantity = 0), // if it is absent, update the productCartQuantity variable created above to zero
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
  dynamic product = widget.product; // widget.variable is used to get the variable defined in the original statefulClass
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,

        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
            
                // first the image carousel
                Stack(
                  children:[
                   
                    ProductImageSlider( images:product["images"], changeActiveIdxFunction:setActiveCarouselIndex),
                    
                    const Positioned(
                      top:10,
                      left: 10,
                      child: CustomBackButton(), // this is from sliderTopButtons.dart
                    ),
            
                    Positioned(
                      top: 10,
                      right: 10,
                      child: FavButton( product:product, isFav:isFav, callback: callCheckFav) // this is from sliderTopButtons.dart
                    ),
                  
                    Positioned(
                      bottom: 10,
                      left: 0, // left:0 and right:0 makes it take the whole width
                      right: 0,
                      child: Align(
                        alignment: Alignment.center, // then we align this in center in that width
                        child: CarouselIndicators(
                          numberOfIndicators: product["images"].length,
                          activeCarouselIndex: activeCarouselIndex,
                        ),
                      ),
                    )
                  
                  ]
                ),
            
                // then the rest.. (product title,etc...)
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top:20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product["title"], style: const TextStyle(fontSize:25,fontWeight:FontWeight.bold) ),
                            IconButton(
                              // using Share_plus package
                              onPressed: ()=>Share.share("http://www.google.com/${product["_id"]}", subject: "sharing product"),
                              padding: const EdgeInsets.all(4),
                              icon: const Icon(Icons.share_outlined)
                            )
                          ],
                        ),
                        const SizedBox(height: 10), // some spacing
                        
                        (product["discountPrice"] != 0 ? // if the product has a discount
                        Row(
                          children: [
                            Text(
                              "$currency.${product["price"]}   ",
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 127, 125, 125),
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                backgroundColor: Colors.red[50]
                                ),
                              ),
                            Text(
                              "$currency.${product["price"]-product["discountPrice"]}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 127, 125, 125),
                                ),
                              ),
                          ],
                        )
                        : Text(
                          "$currency ${product["price"]-product["discountPrice"]}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 127, 125, 125),
                            fontWeight: FontWeight.bold,
                            ),
                          )
                          ),
                      const SizedBox(height: 20), // some spacing
                      Row( // there will be an alternative to this in future (We didnt want to make the container take full width)
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical:7),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                "${product["brand"]}  ", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                                ),
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 50, 221, 67),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // some spacing
                      const Text("Description", style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                      )),
                      const SizedBox(height: 7), // some spacing
                      Text(
                        product["description"],
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                      const SizedBox(height: 200), // some spacing
                    ]
                    ),
                ),
              ],
            ),
          ),

        //now the bottomNavBar
        bottomNavigationBar: BottomAppBar(
          height: 130,
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Container(
                  width: double.maxFinite,
                  color: Colors.white10,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ( productCartQuantity==0? // if the product id not there in the cart
                      ElevatedButton.icon(
                      onPressed: (){},
                      icon: const Icon(Icons.shopping_cart),
                      iconAlignment: IconAlignment.start,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        fixedSize: const Size(180, 48),
                        backgroundColor: const Color.fromARGB(255, 15, 109, 186),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) ),
                      ),
                      label:  const Text(
                        "Add to Cart",
                        style: TextStyle( fontSize:18,fontWeight:FontWeight.bold )
                        ),
                    )
                    : Row( // otherwise show these buttons
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: (){},
                          // onPressed: ()=>subtractQuantity(context, widget.product, assignProductCartQuantity),
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
                              "1",
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
                          onPressed: (){},
                          // onPressed: ()=>addQuantity(context, widget.product, assignProductCartQuantity),
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
                ),
                const CustomBottomNavBar()
            ]
          ),
        ),
      ),
    );
  }
}