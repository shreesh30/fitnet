import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewUser extends StatefulWidget {
  NewUser({this.name});

  static const String id = 'new_user_page';
  final String name;
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future getUserInfo() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;

    Firestore.instance
        .collection('users')
        .document(uid)
        .setData({'userId': uid, 'userName': widget.name, 'email': user.email});
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('new user'));
  }
}
