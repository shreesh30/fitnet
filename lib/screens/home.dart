import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String userName;
  

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future getUserInfo()async {
  var firebaseUser=await FirebaseAuth.instance.currentUser();
      _firestore.collection("users").document(firebaseUser.uid).get().then((value){
        setState(() {
          userName=value.data['userName'].split(' ')[0];
        });
      
    });
  }
  @override
  Widget build(BuildContext context) {
    getUserInfo();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE ,d MMM').format(now);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(SizeConfig.widthMultiplier * 4.5, 0,
              SizeConfig.widthMultiplier * 4.5, 0),
          child: Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    formattedDate.toString(),
                    style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: SizeConfig.textMultiplier * 2),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hello,$userName',
                    style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: SizeConfig.textMultiplier * 3,
            fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFF171717)),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Expanded(child: Container(),)
              ],
            ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF272727),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), title: Text('Workout')),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), title: Text('Tracker')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), title: Text('Mental Health')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
}
