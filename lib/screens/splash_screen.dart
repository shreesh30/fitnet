import 'dart:async';


import 'package:fitnet/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/constants.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), ()=>Navigator.pushNamed(context, LandingPage.id));
  }

  
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/backgroundimg.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
          Image(image: AssetImage('images/logo.png'), width: 180, height: 180),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'FIT', style: kPageHeading),
                TextSpan(
                  text: 'NET',
                  style: kPageHeading.copyWith(
                    color: Color(0xFFFD5739),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 180),
          
        ],
      ),
    );
  }
}
