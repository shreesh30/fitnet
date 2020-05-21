import 'package:fitnet/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';

class LandingPage extends StatefulWidget {
  static const String id = 'landing_page';

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: 30),
          Container(
            child: Image.asset(
              'images/logo.png',
              height: 200,
              width: 200,
            ),
          ),
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
                    fontSize: 36.0,
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
                    fontSize: 36.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          RoundButton(title: 'Create an account'),
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
                onTap: () {
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
         SizedBox(height:30)
        ],
      ),
    );
  }
}




