
import 'package:ecommerce_mobile/configuration/wishlistConfig.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()=>Navigator.of(context).pop(), // pops current screen from the Navigator 
      style: IconButton.styleFrom(
        backgroundColor: const Color.fromARGB(181, 255, 250, 250)
      ),
      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 27),
    );
  }
}

class FavButton extends StatelessWidget {
  final dynamic product;
  final dynamic callback;
  final dynamic isFav;
  const FavButton({super.key,this.product,this.callback,this.isFav});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(), // defining a border for our button
        borderRadius: BorderRadius.circular(30), // any large radius value can make the border circular
        color: Color.fromARGB(163, 255, 255, 255),
      ),
      child: LikeButton( // from "like_button" package which gives cool animation for like button
        isLiked: isFav,  // to inform it when the button is liked
        size: 45, // button size
        onTap: (isLiked) => toggleFav(context, product, callback,isLiked),
        likeBuilder:(isLiked)=> // likeBuilder takes your custom icon
        Icon(Icons.favorite_outline_rounded,color: isLiked ? Colors.pink :Colors.grey, size: 33)
      ),
    );
  }
}