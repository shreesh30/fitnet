import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/home/tab_screen_home_page.dart';
import 'package:fitnet/models/auth_status_data.dart';
import 'package:fitnet/screens/landing_page.dart';
// import 'package:fitnet/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  static const String id = 'root_page';
  @override
  _RootPageState createState() => _RootPageState();
}

// enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  // AuthStatus authStatus = AuthStatus.notSignedIn;
  // Future<String> currentUser() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   if (user != null) {
  //     return user.uid.toString();
  //   } else
  //     return user.toString();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // currentUser().then((userId) {
    //   print(userId.toString());
    //   setState(() {
    //     authStatus = userId.toString() == null.toString()
    //         ? AuthStatus.notSignedIn
    //         : AuthStatus.signedIn;
    //   });
    // });
    // Provider.of<AuthStatusData>(context).currentUser().then((value) => Provider.of<AuthStatusData>(context).changeData(value));
    // Provider.of<AuthStatusData>(context).changeData();
    Provider.of<AuthStatusData>(context, listen: false).changeData();
  }

  // void _signedIn() {
  //   setState(() {
  //     authStatus = AuthStatus.signedIn;
  //   });
  //   print(authStatus.toString());
  // }

  // void onSignout() {
  //   setState(() {
  //     authStatus = AuthStatus.notSignedIn;
  //   });
  //   print(authStatus.toString());
  // }

  @override
  Widget build(BuildContext context) {
    // return authStatus==AuthStatus.notSignedIn?LandingPage(
    //       onSignedIn: _signedIn,
    //       onSignedOut: onSignout,
    //     ):TabScreenHomePage(
    //       signIn: _signedIn,
    //       signOut: onSignout,
    //       auth: FirebaseAuth.instance,
    //     );
    if (Provider.of<AuthStatusData>(context).authStatus ==
        AuthStatus.signedIn) {
      return TabScreenHomePage();
    } else
      return LandingPage();
    // switch (authStatus) {
    //   case AuthStatus.notSignedIn:
    //     return LandingPage(
    //       onSignedIn: _signedIn,
    //       onSignedOut: onSignout,
    //     );
    //   case AuthStatus.signedIn:
    //     return TabScreenHomePage(
    //       signIn: _signedIn,
    //       signOut: onSignout,
    //       auth: FirebaseAuth.instance,
    //     );
    //   default:
    //     return LandingPage(
    //       onSignedIn: _signedIn,
    //       onSignedOut: onSignout,
    //     );
    // }

    //   if(authStatus==AuthStatus.notSignedIn){
    //            return LandingPage(
    //         onSignedIn: _signedIn,
    //         onSignedOut: onSignout,
    //       );
    //   }
    //   return TabScreenHomePage(auth: FirebaseAuth.instance,signIn: _signedIn,signOut: onSignout,);
    // }
  }
}
