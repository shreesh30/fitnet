import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';
import 'package:fitnet/screens/registration_screen.dart';
import 'package:fitnet/screens/login_screen.dart';

class LandingPageItems extends StatefulWidget {


  @override
  _LandingPageItemsState createState() => _LandingPageItemsState();
}

class _LandingPageItemsState extends State<LandingPageItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.heightMultiplier * 3,
        ),
        Image.asset(
          'images/logo.png',
          height: SizeConfig.heightMultiplier * 20,
          width: SizeConfig.widthMultiplier * 50,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'FIT',
                  style: kPageHeading.copyWith(
                      fontSize: SizeConfig.textMultiplier * 7)),
              TextSpan(
                text: 'NET',
                style: kPageHeading.copyWith(
                    color: Color(0xFFFD5739),
                    fontSize: SizeConfig.textMultiplier * 7),
              )
            ]))
          ],
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 15,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Awesome',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: SizeConfig.textMultiplier * 6,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Training',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: SizeConfig.textMultiplier * 6,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 17,
        ),
        RoundButton(
          title: 'Create an account',
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => RegistrationPage()));
          },
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already on fitnet?',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: SizeConfig.textMultiplier * 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              child: Text(
                'Log in',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: SizeConfig.textMultiplier * 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ],
    );
  }
}
