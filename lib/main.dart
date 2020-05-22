import 'package:fitnet/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/screens/landing_page.dart';
import 'package:fitnet/screens/login_screen.dart';
import 'package:fitnet/screens/home.dart';
import 'package:flutter/services.dart';
import 'package:fitnet/screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xff0f0f0f),
      ),
      initialRoute:LandingPage.id,
      routes: {
        SplashScreen.id:(context)=> SplashScreen(),
        LandingPage.id: (context) => LandingPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id:(context)=>HomePage(),
        RegistrationPage.id:(context)=>RegistrationPage()
      },
    );
  }
}
