import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
              child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 35,
              ),
              Image.asset(
                'images/logo.png',
                height: 90,
                width: 140,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Fitness',
                    style: TextStyle(
                        fontSize: 35.0,
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
                        fontSize: 35.0,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                child: TextField(
                  onChanged: (value) {},
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Name'),
                ),
              ),
               SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Email Address'),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {},
                  decoration:
                      kTextFieldInputDecoration.copyWith(hintText: 'Password'),
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              RoundButton(
                title: 'Sign Up',
                onPressed: () async {},
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
