import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';

const kPageHeading=TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: 40,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              );

var kTextFieldInputDecoration=InputDecoration(
                hintStyle: TextStyle(fontSize: SizeConfig.textMultiplier*2),
                hintText: 'enter value',
                filled: true,
                fillColor: Color(0xFF171717),
                contentPadding:
                    EdgeInsets.symmetric(vertical:SizeConfig.heightMultiplier*2, horizontal: SizeConfig.widthMultiplier*2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF171717)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF171717)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              );

            