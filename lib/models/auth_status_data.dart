import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus { notSignedIn, signedIn }

class AuthStatusData extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      return user.uid.toString();
    } else
      return user.toString();
  }

  void changeData() {
    currentUser().then((userId) {
      authStatus = userId.toString() == null.toString()
          ? AuthStatus.notSignedIn
          : AuthStatus.signedIn;
      notifyListeners();
    });
  }

  void signedIn(){
    authStatus=AuthStatus.signedIn;
    print(authStatus.toString()+'test');
    notifyListeners();
  }

  Future signedOut()async{
    authStatus=AuthStatus.notSignedIn;
    print(authStatus.toString()+'test');
    notifyListeners();
  }
}
