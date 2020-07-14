// import 'package:fitnet/components/icon_content.dart';
import 'package:fitnet/components/reusable_card.dart';
import 'package:fitnet/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../size_config.dart';

class NewUser extends StatefulWidget {
  NewUser({this.name});

  static const String id = 'new_user_page';
  final String name;
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  Future future;
  // Firestore _firestore;
  List names;
  final _firestore = Firestore.instance;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserInfo();
    future = getUserInfo();
  }

  Future getUserInfo() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;

    Firestore.instance
        .collection('users')
        .document(uid)
        .setData({'userId': uid, 'userName': widget.name, 'email': user.email});

    if (await FirebaseAuth.instance.currentUser() != null) {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      _firestore.collection("users").document(firebaseUser.uid).snapshots();
      Future userName =
          _firestore.collection('users').document(firebaseUser.uid).get();
      return userName.then((value) async {
        final String name = await value.data['userName'];
        final String email = await value.data['email'];
        return [name, email];
      });
    }
    return null;
  }

  //   Future<String> getUserInfo() async {
  //   // await FirebaseAuth.instance.currentUser().then((value) => print(value));
  //   if (await FirebaseAuth.instance.currentUser() != null) {
  //     var firebaseUser = await FirebaseAuth.instance.currentUser();
  //     _firestore.collection("users").document(firebaseUser.uid).snapshots();
  //     Future userName =
  //         _firestore.collection('users').document(firebaseUser.uid).get();
  //     return userName.then((value) async {
  //       final String name = await value.data['userName'].split(' ')[0];
  //       return name;
  //     });
  //   }
  //   return null;
  // }

  String capitalize(String s) {
    if (!s.contains(" ")) {
      return s[0].toUpperCase() + s.substring(1);
    }
    // else
    //   names=s.split(' ');
    // print(name);
    // List names=s.split(" ");
    // print(names);
    // return null;
    // names.forEach((element) { element[0].toUpperCase()+s.substring(1);});
    else
      names = s.split(' ');
    for (int i = 0; i < names.length; i++) {
      names[i] = names[i][0].toUpperCase() + names[i].substring(1);
    }
    return names.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (BuildContext context, UserData userData, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF0F0F0F),
            title: Text(
              'New User',
              style: TextStyle(
                  fontFamily: 'CopperPlate',
                  fontSize: SizeConfig.textMultiplier * 3,
                  fontWeight: FontWeight.w400),
            ),
          ),
          // body: ListView(
          //   children: <Widget>[
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Form(child: FormField(builder: (field) {
          //     return Text('data');
          //   },))
          // )
          //     FutureBuilder(
          //       future: future,
          //       builder: (context, snapshot) {
          //         switch (snapshot.connectionState) {
          //           case ConnectionState.waiting:
          //             return Center(child: CircularProgressIndicator());

          //           default:
          //             if (snapshot.hasError ||
          //                 !snapshot.hasData ||
          //                 snapshot.connectionState == ConnectionState.none)
          //               return Center(child: new CircularProgressIndicator());
          //             else
          //               return Column(
          //                 children: <Widget>[
          //                   ListTile(
          //                     leading: Icon(Icons.person),
          //                   )
          //                 ],
          //               );
          //         }
          //       },
          //     )
          //   ],
          // ),
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
                    // print(snapshot.data);
                    return Container(
                      padding: SizeConfig.widthMultiplier < 8
                          ? EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 2,
                              horizontal: SizeConfig.widthMultiplier * 3.5)
                          : EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier * 4,
                              horizontal: SizeConfig.widthMultiplier * 5.5),
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 4,
                            ),
                            // title: Form(
                            //   child: FormField(
                            //     builder: (field) {},
                            //   ),
                            // ),
                            title: Row(
                              children: <Widget>[
                                SizeConfig.widthMultiplier < 8
                                    ? SizedBox(
                                        width: 0,
                                      )
                                    : SizedBox(
                                        width: SizeConfig.widthMultiplier,
                                      ),
                                Text(
                                  '${capitalize(snapshot.data[0])}',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: SizeConfig.textMultiplier * 2.5,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier < 8
                                ? SizeConfig.heightMultiplier
                                : SizeConfig.heightMultiplier * 3,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.mail_outline,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 3,
                            ),
                            // title: Form(
                            //   child: FormField(
                            //     builder: (field) {},
                            //   ),
                            // ),
                            title: Row(
                              children: <Widget>[
                                SizeConfig.widthMultiplier < 8
                                    ? SizedBox(
                                        width: 0,
                                      )
                                    : SizedBox(
                                        width: SizeConfig.widthMultiplier*2,
                                      ),
                                Text(
                                  '${snapshot.data[1]}',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: SizeConfig.textMultiplier * 2.5,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier < 8
                                ? SizeConfig.heightMultiplier
                                : SizeConfig.heightMultiplier * 2.5,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 3,
                            ),
                            // title: Form(
                            //   child: FormField(
                            //     builder: (field) {},
                            //   ),
                            // ),
                            // title: Text(
                            //   '${snapshot.data[1]}',
                            //   style: TextStyle(
                            //       fontFamily: 'Roboto',
                            //       fontSize: SizeConfig.textMultiplier * 2.5,
                            //       fontWeight: FontWeight.w300),
                            // ),
                            title: TextField(
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              // buildCounter: (context, {currentLength, isFocused, maxLength}) {

                              // },
                              // maxLength: 10,
                              // maxLengthEnforced: true
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.heightMultiplier * 1.5,
                                      horizontal:
                                          SizeConfig.widthMultiplier * 2),
                                  hintStyle: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2)),
                              onChanged: (value) {
                                userData.userNumber = int.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier < 8
                                ? SizeConfig.heightMultiplier
                                : SizeConfig.heightMultiplier * 2,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.cake,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 3,
                            ),
                            title: TextField(
                               style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              keyboardType: TextInputType.number,
                              controller: ageController,
                              decoration: InputDecoration(
                                  hintText: 'Age',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.heightMultiplier * 1.5,
                                      horizontal:
                                          SizeConfig.widthMultiplier * 2),
                                  hintStyle: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2)),
                              onChanged: (value) {
                                userData.userAge = int.parse(value);
                              },
                            ),
                          ),
                          // SizedBox(height: SizeConfig.heightMultiplier*2,),
                          SizedBox(
                            height: SizeConfig.widthMultiplier < 8
                                ? SizeConfig.heightMultiplier * 2
                                : SizeConfig.heightMultiplier * 3.5,
                          ),
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.venusMars,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 3,
                            ),
                            title: Container(
                              child: Row(
                                children: <Widget>[
                                 SizedBox(width: SizeConfig.widthMultiplier*2,),
                                  ReusableCard(
                                    onPress: userData.changeGenderToMale,
                                    colour:
                                        userData.selectedGender == Gender.male
                                            ? Color(0xFFFD5739)
                                            : Color(0xFF595959),
                                    cardChild: Center(
                                      child: Text(
                                        'Male',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 4,
                                  ),
                                  ReusableCard(
                                    onPress: userData.changeGenderToFemale,
                                    colour:
                                        userData.selectedGender == Gender.female
                                            ? Color(0xFFFD5739)
                                            : Color(0xFF595959),
                                    cardChild: Center(
                                      child: Text(
                                        'Female',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier < 8
                                ? SizeConfig.heightMultiplier * 2
                                : SizeConfig.heightMultiplier * 3.5,
                          ),
                          ListTile(
                            trailing: Text(
                              'kg',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                            ),
                            leading: Icon(
                              FontAwesomeIcons.weight,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 2.7,
                            ),
                            title: TextField(
                               style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              keyboardType: TextInputType.number,
                              controller: weightController,
                              decoration: InputDecoration(
                                  hintText: 'Weight',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.heightMultiplier * 1.5,
                                      horizontal:
                                          SizeConfig.widthMultiplier * 2),
                                  hintStyle: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2)),
                              onChanged: (value) {
                                userData.userWeight = double.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier < 8
                                ? SizeConfig.heightMultiplier
                                : SizeConfig.heightMultiplier * 2.5,
                          ),
                          ListTile(
                            trailing: Text(
                              'cm',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                            ),
                            leading: Icon(
                              FontAwesomeIcons.ruler,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 2.7,
                            ),
                            title: TextField(
                               style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              keyboardType: TextInputType.number,
                              controller: heightController,
                              decoration: InputDecoration(
                                  hintText: 'Height',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.heightMultiplier * 1.5,
                                      horizontal:
                                          SizeConfig.widthMultiplier * 2),
                                  hintStyle: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2)),
                              onChanged: (value) {
                                userData.userHeight = double.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier < 8
                                ? SizeConfig.heightMultiplier
                                : SizeConfig.heightMultiplier * 2.5,
                          ),
                          ListTile(
                            // trailing: Text(
                            //   'cm',
                            //   style: TextStyle(
                            //       fontFamily: 'Roboto',
                            //       fontSize: SizeConfig.textMultiplier * 2,fontWeight: FontWeight.w300),
                            // ),
                            leading: Icon(
                              FontAwesomeIcons.shoePrints,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 2.7,
                            ),
                            // title: TextField(
                            //   inputFormatters: [
                            //     LengthLimitingTextInputFormatter(3),
                            //   ],
                            //   keyboardType: TextInputType.number,
                            //   controller: heightController,
                            //   decoration: InputDecoration(
                            //       hintText: 'Height',
                            //       border: InputBorder.none,
                            //       contentPadding: EdgeInsets.symmetric(
                            //           vertical: SizeConfig.heightMultiplier * 1.5,
                            //           horizontal: SizeConfig.widthMultiplier * 2),
                            //       hintStyle: TextStyle(
                            //           fontSize: SizeConfig.textMultiplier * 2)),
                            //   onChanged: (value) {
                            //     userData.userHeight = double.parse(value);
                            //   },
                            // ),
                            title: DropdownButton(items: [], onChanged: null),
                          ),
                        ],
                      ),
                    );
              }
            },
          ),
        );
      },
    );
  }
}
