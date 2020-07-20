import 'package:fitnet/home/tab_screen_home_page.dart';
import 'package:fitnet/models/auth_status_data.dart';
import 'package:fitnet/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  static const String id = 'root_page';
  @override
  _RootPageState createState() => _RootPageState();
}


class _RootPageState extends State<RootPage> {


  @override
  void initState() {
    super.initState();
  
    Provider.of<AuthStatusData>(context, listen: false).changeData();
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<AuthStatusData>(
      builder: (BuildContext context, AuthStatusData value, Widget child) {
 
      switch(value.authStatus){
        case AuthStatus.notSignedIn:
          return LandingPage();
        case AuthStatus.signedIn:
          return TabScreenHomePage();
        default:
          return LandingPage();
      }
      },
    );

  }
}
