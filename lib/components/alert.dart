import 'package:flutter/material.dart';

alert(BuildContext context, String msg){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:Text("Login"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                }
            )
          ],
        );
      }
  );
}