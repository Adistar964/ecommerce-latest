
// this will help in showing alert messages

import 'package:flutter/material.dart';

alert( context,title,body ){
      showDialog( // show alert dialog!
          context: context, 
          builder: (context){
              return AlertDialog(
                title:const Text(title),
                content: const Text(body),
                actions: [
                  Align(
                    alignment: Alignment.center, // aligning this button to the left
                    child: TextButton(
                      onPressed: ()=>Navigator.of(context).pop(), // removes this alertDialog
                      child: const Text("ok")
                      )
                  )
                ]
              );
            });
}