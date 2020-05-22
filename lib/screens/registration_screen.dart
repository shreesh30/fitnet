import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/screens/new_user.dart';
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
  bool showSpinner=false;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
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
                    onChanged: (value) {
                      name = value;
                    },
                    decoration:
                        kTextFieldInputDecoration.copyWith(hintText: 'Name'),
                  ),
                ),
                SizedBox(height: 20.0),
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
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: RoundButton(
                    title: 'Sign Up',
                    onPressed: () async {
                      setState(() {
                        showSpinner=true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          _firestore.collection('users').add(
                              {'userId': newLoggedUser.uid, 'userName': name});

                          Navigator.pushNamed(context, NewUser.id);
                        }
                        setState(() {
                          showSpinner=false;
                        });
                      } catch (signUpError)  {
                          
                       print('signUpError');
                        
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
      ),
    );
  }
}
