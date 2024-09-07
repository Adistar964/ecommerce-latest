
// this will help in showing alert messages

import 'package:flutter/material.dart';

alert( context,title,body ){
    showDialog( // show alert dialog!
        context: context, 
        builder: (context){
            return AlertDialog(
              title: Text(title),
              content: Text(body),
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

// for showing a message a message
toast(context, message){
  showDialog(
    context: context,
    builder: (context) => SnackBar(
      content: Text(message),
    )
  );
}