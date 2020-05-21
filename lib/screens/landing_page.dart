import 'package:fitnet/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';

class LandingPage extends StatefulWidget {

  static const String id='landing_page';

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Image.asset(
                'images/logo.png',
                height: 200,
                width: 200,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(text: 'FIT', style: kLandingPageHeading),
                TextSpan(
                    text: 'NET',
                    style:
                        kLandingPageHeading.copyWith(color: Color(0xFFFD5739)))
              ]))
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 70.0, 0.0, 0.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Awesome',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Training',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          RoundButton(title: 'Create an account',),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Already on fitnet?',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, LoginPage.id);
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}



