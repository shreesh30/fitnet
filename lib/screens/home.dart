import 'package:fitnet/screens/workout_list.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/components/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String userName = "";

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

  Future<String> getUserInfo() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    await _firestore.collection("users").document(firebaseUser.uid).snapshots();
    Future userName =
        _firestore.collection('users').document(firebaseUser.uid).get();
    return userName.then((value) async {
      final String name = await value.data['userName'].split(' ')[0];
      return name;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
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
              FutureBuilder<String>(
                future: getUserInfo(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('');
                    default:
                      if (snapshot.hasError)
                        return new Text('');
                      else
                        return Align(
                          alignment: Alignment.topLeft,
                          child: new Text(
                            'Hello,${snapshot.data}',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: SizeConfig.textMultiplier * 3,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                  }
                },
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 1.5),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xFF171717)),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Foods',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: SizeConfig.textMultiplier * 3,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Show More',
                    style: TextStyle(color: Color(0xFF8B8A8D),fontSize: SizeConfig.textMultiplier*1.8),
                  )
                ],
              ),
              Expanded(
                child: Container(child: null),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Workout List',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: SizeConfig.textMultiplier * 3,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,WorkoutList.id);
                    },
                      child: Text(
                    'Show More',
                    style: TextStyle(color: Color(0xFF8B8A8D),fontSize: SizeConfig.textMultiplier*1.8),
                  ))
                ],
              ),
              Expanded(
                child: Container(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}



// Future<String> getUserInfo() async {
//   var firebaseUser = await FirebaseAuth.instance.currentUser();
//   _firestore.collection("users").document(firebaseUser.uid).snapshots();
//   Future userName = _firestore.collection('users').document(firebaseUser.uid).get();
//   return userName.then((value){
//     final String name=value.data['userName'];
//   });
// }

// Future<String> getUserInfo()async {
// var firebaseUser=await FirebaseAuth.instance.currentUser();
//    await  _firestore.collection("users").document(firebaseUser.uid).get().then((value){
//       setState(()  {
//       userName= value.data['userName'].split(' ')[0];
//       });
//   });
//   return userName;
// }
