import 'package:fitnet/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fitnet/size_config.dart';

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
            height: SizeConfig.heightMultiplier*4,
          ),
          Image.asset(
            'images/logo.png',
            height:SizeConfig.heightMultiplier*16,
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier*2.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'FIT', style: kPageHeading.copyWith(fontSize: SizeConfig.textMultiplier*6)),
                TextSpan(
                    text: 'NET',
                    style:
                        kPageHeading.copyWith(color: Color(0xFFFD5739),fontSize: SizeConfig.textMultiplier*6))
              ],
            ),
          ),
            ],
          ),
          SizedBox(
            height:SizeConfig.heightMultiplier*6,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier*6),
            child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Fitness',
            style: TextStyle(
                fontSize:  SizeConfig.textMultiplier*5.5,
                decoration: TextDecoration.none,
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal),
          ),
            ),
          ),
        
          Padding(
            padding:  EdgeInsets.only(left: SizeConfig.widthMultiplier*6),
            child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'First',
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier*5.5,
                decoration: TextDecoration.none,
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal),
          ),
            ),
          ),
          SizedBox(height:  SizeConfig.heightMultiplier*5),
          Padding(
            padding: EdgeInsets.symmetric(vertical:0,horizontal: SizeConfig.widthMultiplier*6),
            child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            email = value;
          },
          decoration: kTextFieldInputDecoration.copyWith(
              hintText: 'Email Address'),
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier*3),
          Padding(
            padding: EdgeInsets.symmetric(vertical:0,horizontal: SizeConfig.widthMultiplier*6),
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
           height:SizeConfig.heightMultiplier*5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical:0,horizontal: SizeConfig.widthMultiplier*6),
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
          
            ],
          ),
        ),
      ),
    );
  }
}
