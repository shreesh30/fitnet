import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.title,this.onPressed});

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 180.0, 0.0, 10.0),
      child: Material(
        elevation: 5.0,
        color: Color(0xFFFD5739),
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 350,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
