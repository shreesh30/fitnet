import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/components/rounded_button.dart';
import 'package:fitnet/models/user_data.dart';
import 'package:fitnet/screens/root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class NewUser3 extends StatefulWidget {
  static const String id = 'new_user_3';
  @override
  _NewUser3State createState() => _NewUser3State();
}

class _NewUser3State extends State<NewUser3> {
  Future setUserInfo() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    Firestore.instance.collection('users').document(uid).setData({
      'userId': uid,
      'userName': Provider.of<UserData>(context, listen: false).userName,
      'email': user.email,
      'gender': Provider.of<UserData>(context, listen: false).userGender,
      'age': Provider.of<UserData>(context, listen: false).userAge,
      'mobileNumber': Provider.of<UserData>(context, listen: false).userNumber,
      'height': Provider.of<UserData>(context, listen: false).userHeight,
      'weight': Provider.of<UserData>(context, listen: false).userWeight,
      'activity': Provider.of<UserData>(context, listen: false).userActivity,
      'maintenanceCal':
          Provider.of<UserData>(context, listen: false).finalUserMaintenanceCal
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (BuildContext context, UserData userData, Widget child) {
        return Scaffold(
     
          body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 10,
                  ),
                  Text(
                    userData.userName.split(" ")[0] + ',',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        fontSize: SizeConfig.textMultiplier * 3),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  userData.userWeight > userData.targetWeight
                      ? Text('Based on your weight loss goal of',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.textMultiplier * 2.5))
                      : userData.userWeight < userData.targetWeight
                          ? Text('Based on your weight gain goal of',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  fontSize: SizeConfig.textMultiplier * 2.5))
                          : Text('Based on your weight goal :',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  fontSize: SizeConfig.textMultiplier * 2.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      userData.userWeight == userData.targetWeight
                          ? Text(
                              'Maintaining the weight of ' +
                                  userData.userWeight.toStringAsFixed(0) +
                                  ' kg',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.textMultiplier * 2.6))
                          : Text(
                              userData.differenceWeight.toStringAsFixed(0) +
                                  ' kg in about ' +
                                  (userData.goalReachingTime != null
                                      ? userData.goalReachingTime
                                          .toStringAsFixed(1)
                                      : '') +
                                  ' months',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.textMultiplier * 2.6)),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Your Daily Calorie Budget is',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.textMultiplier * 2.5)),
                    ],
                  ),
                  Text(
                      userData.finalUserMaintenanceCal.toStringAsFixed(0) +
                          ' Cal',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.textMultiplier * 3.5)),
                  SizedBox(height: SizeConfig.heightMultiplier * 35),
                  Text('Teacking increases chances of meeting',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 2)),
                  Text('your goal by 3x',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 2)),
                  Text('Start now!',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 2))
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              RoundButton(
                title: 'Finish',
                onPressed: () {
                  var popCount=0;
                  setUserInfo();
                 userData.userProfileEditingPage=='profile_editing'?Navigator.popUntil(context, (route) => popCount++ == 3) :Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => RootPage(),
                      ));
                
                },
              )
           
            ],
          ),
        );
      },
    );
  }
}
