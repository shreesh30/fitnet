import 'package:fitnet/home/tab_screen_home_page.dart';
import 'package:fitnet/main.dart';
import 'package:fitnet/models/auth_status_data.dart';
import 'package:fitnet/screens/landing_page.dart';
import 'package:fitnet/screens/root_page.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  static const String id = 'user_profile';
  // final FirebaseAuth auth;

  // const UserProfile({Key key, this.onSignOut, this.auth}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
// final _auth=FirebaseAuth.instance;
  // Future<FirebaseAuth> _firebaseAuth;
  // FirebaseAuth _auth;
  Future<void> signOut() async {
    print('before trying signout');

    var auth = await FirebaseAuth.instance.signOut();
    // if(FirebaseAuth.instance.currentUser()!=null){
    //       print(widget.auth.currentUser().toString());
    // }
    // print(widget.auth.currentUser().toString());
    print('after trying signout');
    // return widget.auth.currentUser().then((value) => widget.auth.signOut());
    return auth;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   super.initState();
  //   FirebaseAuth.instance;
  //   // getFirebaseAuthInstance();
  //   // setState(()async {
  //   //   auth=await FirebaseAuth.instance.signOut();
  //   // });

  // }

  void _signOut() async {
    try {
      print('trying once');
      await signOut();
      await Provider.of<AuthStatusData>(context).signedOut();
      // widget.onSignOut();
      // Navigator.of(context).pop(TabScreenHomePage());
      // Navigator.of(context).popUntil(ModalRoute.withName(RootPage.id));
      // Navigator.pushReplacement(context,CupertinoPageRoute(builder: (context) => RootPage(),));
      // Navigator.pushReplacement();
      // Navigator.pushReplacement(context,CupertinoPageRoute(builder: (context) => LandingPage(),));
      // Navigator.pop(context,TabScreenHomePage());
    } catch (e) {
      print(e);
      print('error');
    }
  }

  Future<void> getFirebaseAuthInstance() async {
    // _firebaseAuth=await FirebaseAuth.instance;
    //   setState(() async{
    //   var auth2=await FirebaseAuth.instance.signOut();
    // });
    // return await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthStatusData>(
      builder: (BuildContext context, AuthStatusData value, Widget child) {
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  // _signOut();
                  try {
                    await signOut();
                    value.signedOut();
                    // RootPage();
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
            centerTitle: true,
            automaticallyImplyLeading: false,
            //  leading: IconButton(
            //     padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
            //     icon: Icon(
            //       Icons.arrow_back_ios,
            //       size: SizeConfig.heightMultiplier * 3,
            //       color: Color(0xFFFD5739),
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     }),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Profile',
                style: TextStyle(
                    fontFamily: 'CopperPlate',
                    fontSize: SizeConfig.textMultiplier * 3,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: Color(0xFF0F0F0F),
          ),
        );
      },
    );
  }
}
