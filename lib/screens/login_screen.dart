import 'package:flutter/material.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fitness',
                style: TextStyle(
                    fontSize: 36.0,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'First',
                style: TextStyle(
                    fontSize: 36.0,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          Padding(
            padding: EdgeInsets.fromLTRB(25.0,0.0,25.0,0.0),
            child: TextField(
              // textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
              decoration: kTextFieldInputDecoration.copyWith(hintText: 'Email Address'),
            ),
          ),
          SizedBox(height:20.0),
           Padding(
            padding: EdgeInsets.fromLTRB(25.0,0.0,25.0,0.0),
            child: TextField(
              // textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
              decoration: kTextFieldInputDecoration.copyWith(hintText: 'Password'),
            ),
          ),
         
          RoundButton(title:'Sign In',onPressed: (){},),
          
        ],
      ),
    );
  }
}
