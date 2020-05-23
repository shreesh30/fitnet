import 'package:fitnet/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';
import 'package:fitnet/screens/registration_screen.dart';
import 'package:fitnet/size_config.dart';

class LandingPage extends StatefulWidget {
  static const String id = 'landing_page';

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: SizeConfig.heightMultiplier*3,),
            Image.asset(
              'images/logo.png',
              height: SizeConfig.heightMultiplier*20,
              width: SizeConfig.widthMultiplier*60,
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(text: 'FIT', style: kPageHeading.copyWith(fontSize:SizeConfig.textMultiplier*8)),
                  TextSpan(
                      text: 'NET',
                      style: kPageHeading.copyWith(
                          color: Color(0xFFFD5739),fontSize: SizeConfig.textMultiplier*8))
                ]))
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier*15,
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
                      fontSize: SizeConfig.textMultiplier*6,
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
                      fontSize: SizeConfig.textMultiplier*6,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            SizedBox(
              height:SizeConfig.heightMultiplier*19,
            ),
            RoundButton(
              title: 'Create an account',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationPage.id);
              },
            ),
            SizedBox(height: SizeConfig.heightMultiplier,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already on fitnet?',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: SizeConfig.textMultiplier*1.5,
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
                        fontSize: SizeConfig.textMultiplier*1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
