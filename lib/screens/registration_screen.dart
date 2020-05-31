import 'package:fitnet/screens/new_user.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/components/rounded_button.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String name;
  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  FirebaseUser newLoggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        newLoggedUser = user;
        print(newLoggedUser.uid);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Image.asset(
                  'images/logo.png',
                  height: SizeConfig.heightMultiplier * 16,
                  // width: SizeConfig.widthMultiplier*30,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'FIT',
                              style: kPageHeading.copyWith(
                                  fontSize: SizeConfig.textMultiplier * 6)),
                          TextSpan(
                            text: 'NET',
                            style: kPageHeading.copyWith(
                                color: Color(0xFFFD5739),
                                fontSize: SizeConfig.textMultiplier * 6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 5,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.widthMultiplier * 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fitness',
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 5.5,
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.widthMultiplier * 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'First',
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 5.5,
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 3),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: SizeConfig.widthMultiplier * 6),
                  child: TextField(
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
                    onChanged: (value) {
                      name = value;
                    },
                    decoration:
                        kTextFieldInputDecoration.copyWith(hintText: 'Name'),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 3),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: SizeConfig.widthMultiplier * 6),
                  child: TextField(
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldInputDecoration.copyWith(
                        hintText: 'Email Address'),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 3),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: SizeConfig.widthMultiplier * 6),
                  child: TextField(
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldInputDecoration.copyWith(
                        hintText: 'Password'),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: SizeConfig.widthMultiplier * 6),
                  child: RoundButton(
                    title: 'Sign Up',
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return NewUser(name: name,);
                          }));
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (signUpError) {
                        print('signUpError');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//  _firestore.collection('users').add(
//                               {'userId': newLoggedUser.uid, 'userName': name,'email':email});