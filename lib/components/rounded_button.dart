import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.title,this.onPressed});

  final String title;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Color(0xFFFD5739),
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        padding: EdgeInsets.all(22),
        onPressed: onPressed,
        minWidth: 350,
        height: 42.0,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }
}
