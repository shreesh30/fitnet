import 'package:flutter/material.dart';
import 'package:fitnet/screens/landing_page.dart';
import 'package:fitnet/screens/login_screen.dart';
import 'package:fitnet/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xff0f0f0f),
      ),
      initialRoute:LandingPage.id,
      routes: {
        LandingPage.id: (context) => LandingPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id:(context)=>HomePage()
      },
    );
  }
}
