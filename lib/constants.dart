import 'package:flutter/material.dart';

const kPageHeading=TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: 40,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              );

const kTextFieldInputDecoration=InputDecoration(
                hintText: 'enter value',
                filled: true,
                fillColor: Color(0xFF171717),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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