import 'package:ecommerce_mobile/configuration/providerConfig.dart';
import 'package:ecommerce_mobile/helper_components/productsSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedProductsContainer extends StatelessWidget {
  const FeaturedProductsContainer({super.key});

  @override
  Widget build(BuildContext context) {

    // you mustnt use context.read<Ur_ProviderName>() inside the build function
    // but use Provider.of<Ur_providerName>(context,listen:false)
    final homeData = Provider.of<MyProvider>(context,listen: true).homeData;

    return Column(
      children:
        homeData["images and products"].map<Widget>( (featuredProductThings) =>
            FeaturedProducts(
              featuredProductsImage: featuredProductThings["image"], 
              products: featuredProductThings["products"]
              )
          ).toList()
      );
    }
}

class FeaturedProducts extends StatelessWidget {
  final dynamic featuredProductsImage;
  final dynamic products;
  const FeaturedProducts({super.key,this.featuredProductsImage,this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // First the header image(image describing the featured products)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 110,
              width: double.maxFinite,
              child: Image.network(featuredProductsImage,
               fit: BoxFit.fill),
            ),
          ),

          // then the carousel-slider for the featured-products
          ProductSlider(products: products)
      ],
    );
  }
}

