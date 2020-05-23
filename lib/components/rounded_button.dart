import 'package:fitnet/size_config.dart';
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
      borderRadius: BorderRadius.circular(100.0),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical:SizeConfig.heightMultiplier*2,horizontal: SizeConfig.widthMultiplier*15),
        onPressed: onPressed,
        minWidth: SizeConfig.widthMultiplier*40,
        height: SizeConfig.heightMultiplier*2,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: SizeConfig.textMultiplier*2),
        ),
      ),
    );
  }
}
