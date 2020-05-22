import 'package:fitnet/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  bool showSpinner=false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
              child: Container(
          child: ListView(
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
                    style:
                        kPageHeading.copyWith(color: Color(0xFFFD5739)))
              ],
            ),
          ),
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
          SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
            child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            email = value;
          },
          decoration: kTextFieldInputDecoration.copyWith(
              hintText: 'Email Address'),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
            child: TextField(
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
          decoration:
              kTextFieldInputDecoration.copyWith(hintText: 'Password'),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0,25, 0),
            child: RoundButton(
              title: 'Sign In',
              onPressed: () async {
                setState(() {
                  showSpinner=true;
                });
            final user = await _auth.signInWithEmailAndPassword(
                email: email, password: password);
            try {
              if (user != null) {
                Navigator.pushNamed(context, HomePage.id);
              }
              setState(() {
                showSpinner=false;
              });
            } catch (e) {
              print(e);
            }
              },
            ),
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
