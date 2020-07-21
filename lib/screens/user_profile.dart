import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/components/rounded_button.dart';

import 'package:fitnet/models/auth_status_data.dart';
import 'package:fitnet/models/user_data.dart';

import 'package:fitnet/screens/user_profile_edit.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  static const String id = 'user_profile';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final _firestore = Firestore.instance;
  Future future;
  List names;
  Future<void> signOut() async {
    print('before trying signout');

    var auth = await FirebaseAuth.instance.signOut();
    
    print('after trying signout');
    return auth;
  }

  @override
  void initState() {

    super.initState();
  
    future = getUserInfo();
  }


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
        final String email = await value.data['email'];
        final int mobileNumber = await value.data['mobileNumber'];
        final String gender = await value.data['gender'];
        final double weight = await value.data['weight'];
        final double height = await value.data['height'];
        final String activity = await value.data['activity'];
      
        return [name, age, email, mobileNumber, gender, weight, height,activity];
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

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthStatusData,UserData>(
      builder:
          (BuildContext context, AuthStatusData authStatusData,UserData userData, Widget child) {
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[

              FutureBuilder(future: future,builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container();

                default:
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.none)
                    return Container();
                  else
                  return  IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Color(0xFFFD5739),
                  size: SizeConfig.textMultiplier * 3,
                ),
                onPressed: () async {
                  try {
                    await signOut();
                    authStatusData.signedOut();
                  } catch (e) {
                    print(e);
                  }
                },
              );
              }}),
             
            ],
            centerTitle: true,
            automaticallyImplyLeading: false,
       
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Profile',
                style: TextStyle(
                    fontFamily: 'CopperPlate',
                    fontSize: SizeConfig.textMultiplier * 3,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: Color(0xFF0F0F0F),
          ),
          body: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
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
                        snapshot.data[4] != null
                            ? snapshot.data[4] == 'male'
                                ? SvgPicture.asset(
                                    'images/male_user.svg',
                                    height: SizeConfig.heightMultiplier * 30,
                                  )
                                : SvgPicture.asset(
                                    'images/female_user.svg',
                                    height: SizeConfig.heightMultiplier * 30,
                                  )
                            : Container(),
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
                                            size: SizeConfig.heightMultiplier *
                                                2.3,
                                          ),
                                          Text(' Name : ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2.5,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                      title: Text(
                                        snapshot.data[0],
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  : Container(),
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
                                            size: SizeConfig.heightMultiplier *
                                                2.3,
                                          ),
                                          Text(' Email :',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2.3,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                      title: Text(
                                        snapshot.data[2],
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  : Container(),
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
                                            size: SizeConfig.heightMultiplier *
                                                2.3,
                                          ),
                                          Text(' Mobile no. : ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2.5,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                      title: Text(
                                        snapshot.data[3].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  : Container(),
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
                                            size: SizeConfig.heightMultiplier *
                                                2.3,
                                          ),
                                          Text(' Age : ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2.5,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                      title: Text(
                                        snapshot.data[1].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  : Container(),
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
                                            size: SizeConfig.heightMultiplier *
                                                2.5,
                                          ),
                                          Text(' Gender : ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2.5,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                      title: Text(
                                        capitalize(snapshot.data[4]),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  : Container(),
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
                                            size: SizeConfig.heightMultiplier *
                                                2.3,
                                          ),
                                          Text(' Height : ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2.5,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                      title: Text(
                                      userData.userProfileEditingPage=='profile_editing'?userData.userHeight.toString():snapshot.data[6].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      trailing: Text(
                                        'cm',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  : Container(),
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
                                            size: SizeConfig.heightMultiplier *
                                                2.3,
                                          ),
                                          Text('  Weight : ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2.5,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                      title: Text(
                                        userData.userProfileEditingPage=='profile_editing'?userData.userWeight.toString():snapshot.data[5].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      trailing: Text(
                                        'kg',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  : Container(),
                                   snapshot.data[7] != null
                                  ? ListTile(
                                      leading: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.shoePrints,
                                            color: Color(0xFFFD5739),
                                            size: SizeConfig.heightMultiplier *
                                                2.3,
                                          ),
                                          Text('  Daily Activity : ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      2.5,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                      title: Text(
                                       userData.userProfileEditingPage=='profile_editing'?userData.userActivity: snapshot.data[7],
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                           
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        RoundButton(
                          title: 'Edit',
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => UserProfileEdit(),
                                ));
                          },
                        )
             
                      ],
                    );
              }
            },
          ),
        );
      },
    );
  }
}
