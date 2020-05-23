import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class User{

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

  Future getUserName()async {
  var firebaseUser=await FirebaseAuth.instance.currentUser();
      _firestore.collection("users").document(firebaseUser.uid).get().then((value){
          userName=value.data['userName'].split(' ')[0];
      
      return userName;
    });
  }
}