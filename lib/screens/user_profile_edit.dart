import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/components/rounded_button.dart';
import 'package:fitnet/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';
import 'new_user2.dart';

class UserProfileEdit extends StatefulWidget {
  static const String id = 'user_profile_edit';
  @override
  _UserProfileEditState createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  final _firestore = Firestore.instance;
  Future future;
  List names;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  Future getUserInfo() async {
    if (await FirebaseAuth.instance.currentUser() != null) {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      _firestore.collection("users").document(firebaseUser.uid).snapshots();
      Future userName =
          _firestore.collection('users').document(firebaseUser.uid).get();
      return userName.then((value) async {
        final String name = await value.data['userName'];
        Provider.of<UserData>(context, listen: false).userName = name;
        final int age = await value.data['age'];
        Provider.of<UserData>(context, listen: false).userAge = age;
        final String email = await value.data['email'];

        final int mobileNumber = await value.data['mobileNumber'];
        Provider.of<UserData>(context, listen: false).userNumber = mobileNumber;
        final String gender = await value.data['gender'];
        Provider.of<UserData>(context, listen: false).userGender = gender;
        final double weight = await value.data['weight'];
        Provider.of<UserData>(context, listen: false).userWeight = weight;
        final double height = await value.data['height'];
        Provider.of<UserData>(context, listen: false).userHeight = height;
        final String activity = await value.data['activity'];
        Provider.of<UserData>(context, listen: false).userActivity = activity;
        final double maintenanceCal= await value.data['maintenanceCal'];
        Provider.of<UserData>(context,listen: false).finalUserMaintenanceCal=maintenanceCal;
  
        return [
          name,
          age,
          email,
          mobileNumber,
          gender,
          weight,
          height,
          activity
        ];
      });
    }
    return null;
  }

  String capitalize(String s) {
    if (!s.contains(" ")) {
      return s[0].toUpperCase() + s.substring(1);
    }
 
    else
      names = s.split(' ');
    for (int i = 0; i < names.length; i++) {
      names[i] = names[i][0].toUpperCase() + names[i].substring(1);
    }
    return names.join(' ');
  }

  Widget servingPopUp(BuildContext context) {
    return Consumer<UserData>(
      builder: (BuildContext context, UserData userData, Widget child) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: SizeConfig.widthMultiplier < 8
                ? SizeConfig.heightMultiplier >= 8
                    ? SizeConfig.heightMultiplier * 45
                    : SizeConfig.heightMultiplier > 7
                        ? SizeConfig.heightMultiplier * 50
                        : SizeConfig.heightMultiplier * 55
                : SizeConfig.heightMultiplier * 40,
            child: Padding(
              padding: SizeConfig.widthMultiplier < 8
                  ? EdgeInsets.symmetric(
                      vertical: SizeConfig.heightMultiplier * 4.5,
                      horizontal: SizeConfig.widthMultiplier * 7)
                  : EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 5,
                      left: SizeConfig.widthMultiplier * 5,
                      right: SizeConfig.widthMultiplier * 5),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Sedentary',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 2.3),
                    ),
                    subtitle: Text(
                      'Little or no exercise',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                    onTap: () {
                      userData.changeUserActivityTo1();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.heightMultiplier
                        : SizeConfig.heightMultiplier * 2.5,
                  ),
                  ListTile(
                    title: Text(
                      'Lightly Active',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 2.3),
                    ),
                    subtitle: Text(
                      'Light exercise / Sports 1-3 days a week',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                    onTap: () {
                      userData.changeUserActivityTo2();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.heightMultiplier
                        : SizeConfig.heightMultiplier * 2.5,
                  ),
                  ListTile(
                    title: Text(
                      'Moderately Active',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 2.3),
                    ),
                    subtitle: Text(
                      'Moderate exercise / Sports 3-5 days a week',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                    onTap: () {
                      userData.changeUserActivityTo3();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.heightMultiplier
                        : SizeConfig.heightMultiplier * 2.5,
                  ),
                  ListTile(
                    title: Text(
                      'Very Active',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 2.3),
                    ),
                    subtitle: Text(
                      'Hard exercise / Sports 6-7 days a week',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                    onTap: () {
                      userData.changeUserActivityTo4();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
      'maintenanceCal':Provider.of<UserData>(context, listen: false).finalUserMaintenanceCal,
    });
  }

  @override
  void initState() {
    super.initState();
    future = getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, UserData userData, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: SizeConfig.heightMultiplier * 3,
                  color: Color(0xFFFD5739),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text(
              'Profile Edit',
              style: TextStyle(
                  fontFamily: 'CopperPlate',
                  fontSize: SizeConfig.textMultiplier * 3,
                  fontWeight: FontWeight.w400),
            ),
            backgroundColor: Color(0xFF0F0F0F),
          ),
          body: FutureBuilder(
              future: future,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());

                  default:
                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.none)
                      return Center(child: new CircularProgressIndicator());
                    else
                      return ListView(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 2,
                                horizontal: SizeConfig.widthMultiplier),
                            child: Column(
                              children: <Widget>[
                                snapshot.data[0] != null
                                    ? ListTile(
                                        leading: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.user,
                                              color: Color(0xFFFD5739),
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      2.3,
                                            ),
                                            Text(' Name : ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.5,
                                                    fontWeight:
                                                        FontWeight.w300))
                                          ],
                                        ),
                                        title: Text(
                                          snapshot.data[0],
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: SizeConfig.widthMultiplier < 8
                                      ? SizeConfig.heightMultiplier * 2
                                      : SizeConfig.heightMultiplier * 3,
                                ),
                                snapshot.data[2] != null
                                    ? ListTile(
                                        leading: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.envelope,
                                              color: Color(0xFFFD5739),
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      2.3,
                                            ),
                                            Text(' Email :',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.3,
                                                    fontWeight:
                                                        FontWeight.w300))
                                          ],
                                        ),
                                        title: Text(
                                          snapshot.data[2],
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: SizeConfig.widthMultiplier < 8
                                      ? SizeConfig.heightMultiplier * 2
                                      : SizeConfig.heightMultiplier * 2.5,
                                ),
                                snapshot.data[3] != null
                                    ? ListTile(
                                        leading: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.phoneAlt,
                                              color: Color(0xFFFD5739),
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      2.3,
                                            ),
                                            Text(' Mobile no. : ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.5,
                                                    fontWeight:
                                                        FontWeight.w300))
                                          ],
                                        ),
                                        title: Text(
                                          snapshot.data[3].toString(),
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: SizeConfig.widthMultiplier < 8
                                      ? SizeConfig.heightMultiplier * 2
                                      : SizeConfig.heightMultiplier * 2,
                                ),
                                snapshot.data[1] != null
                                    ? ListTile(
                                        leading: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.birthdayCake,
                                              color: Color(0xFFFD5739),
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      2.3,
                                            ),
                                            Text(' Age : ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.5,
                                                    fontWeight:
                                                        FontWeight.w300))
                                          ],
                                        ),
                                        title: TextField(
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(4),
                                          ],
                                          keyboardType: TextInputType.number,
                                         
                                          controller: ageController
                                            ..text = userData.userAge == null
                                                ? snapshot.data[1].toString()
                                                : userData.userAge
                                                    .toString(),
                                          decoration: InputDecoration(
                                             
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                              .heightMultiplier *
                                                          1.5,
                                                      horizontal: SizeConfig
                                                              .widthMultiplier *
                                                          2),
                                              hintStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2)),
                                          onChanged: (value) {
                                            userData.userAge =
                                                int.parse(value);
                                          },
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: SizeConfig.widthMultiplier < 8
                                      ? SizeConfig.heightMultiplier * 3
                                      : SizeConfig.heightMultiplier * 3.5,
                                ),
                                snapshot.data[4] != null
                                    ? ListTile(
                                        leading: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              snapshot.data[4] == 'male'
                                                  ? FontAwesomeIcons.venusMars
                                                  : FontAwesomeIcons.venusMars,
                                              color: Color(0xFFFD5739),
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            Text(' Gender : ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.5,
                                                    fontWeight:
                                                        FontWeight.w300))
                                          ],
                                        ),
                                        title: Text(
                                          capitalize(snapshot.data[4]),
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: SizeConfig.widthMultiplier < 8
                                      ? SizeConfig.heightMultiplier * 3
                                      : SizeConfig.heightMultiplier * 3.5,
                                ),
                    
                                snapshot.data[6] != null
                                    ? ListTile(
                                        leading: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.ruler,
                                              color: Color(0xFFFD5739),
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      2.3,
                                            ),
                                            Text(' Height : ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.5,
                                                    fontWeight:
                                                        FontWeight.w300))
                                          ],
                                        ),
                                        title: TextField(
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(5),
                                          ],
                                          keyboardType: TextInputType.number,
                                         
                                          controller: heightController
                                            ..text = userData.userHeight == null
                                                ? snapshot.data[6].toString()
                                                : userData.userHeight
                                                    .toString(),
                                          decoration: InputDecoration(
                                             
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                              .heightMultiplier *
                                                          1.5,
                                                      horizontal: SizeConfig
                                                              .widthMultiplier *
                                                          2),
                                              hintStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2)),
                                          onChanged: (value) {
                                            userData.userHeight =
                                                double.parse(value);
                                          },
                                        ),
                                        trailing: Text(
                                          'cm',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: SizeConfig.widthMultiplier < 8
                                      ? SizeConfig.heightMultiplier * 2
                                      : SizeConfig.heightMultiplier * 2.5,
                                ),
                                snapshot.data[5] != null
                                    ? ListTile(
                                        leading: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.weight,
                                              color: Color(0xFFFD5739),
                                              size:
                                                  SizeConfig.heightMultiplier *
                                                      2.3,
                                            ),
                                            Text('  Weight : ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: SizeConfig
                                                            .textMultiplier *
                                                        2.5,
                                                    fontWeight:
                                                        FontWeight.w300))
                                          ],
                                        ),
                                        title: TextField(
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(5),
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller: weightController
                                            ..text = userData.userWeight == null
                                                ? snapshot.data[5].toString()
                                                : userData.userWeight
                                                    .toString(),
                                          decoration: InputDecoration(
                                         
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                              .heightMultiplier *
                                                          1.5,
                                                      horizontal: SizeConfig
                                                              .widthMultiplier *
                                                          2),
                                              hintStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2)),
                                          onChanged: (value) {
                                            userData.userWeight =
                                                double.parse(value);
                                          },
                                        ),
                                        trailing: Text(
                                          'kg',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: SizeConfig.widthMultiplier < 8
                                      ? SizeConfig.heightMultiplier * 2
                                      : SizeConfig.heightMultiplier * 2.5,
                                ),
                                ListTile(
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.shoePrints,
                                        color: Color(0xFFFD5739),
                                        size: SizeConfig.heightMultiplier * 2.7,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier,
                                      ),
                                      Text(' Daily Activity :',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.45,
                                              fontWeight: FontWeight.w300))
                                    ],
                                  ),
                                  title: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                   
                                      Provider.of<UserData>(context)
                                                  .userActivity ==
                                              null
                                          ? Text(
                                              snapshot.data[7],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2),
                                            )
                                          : Text(
                                              Provider.of<UserData>(context)
                                                  .userActivity,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2),
                                            )
                                    ],
                                  ),
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) =>
                                          servingPopUp(context),
                                    );
                                  },
                                  trailing: Icon(Icons.arrow_drop_down,
                                      size: SizeConfig.heightMultiplier * 3,
                                      color: Color(0xFFFD5739)),
                                ),

                              
                              ],
                            ),
                          ),
                          RoundButton(
                            title: 'Next',
                            onPressed: () {
                              userData.userProfileEditingPage =
                                  'profile_editing';
                              setUserInfo();
                              userData.calculateBMI();
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => NewUser2(),
                                  ));
                            },
                          )
                        ],
                      );
                }
              }),
        );
      },
    );
  }
}
