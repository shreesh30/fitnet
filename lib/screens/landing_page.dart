import 'package:flutter/material.dart';
import 'package:fitnet/widgets/landing_page_items.dart';

class LandingPage extends StatefulWidget {
  static const String id = 'landing_page';


  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LandingPageItems(),
      ),
    );
  }
}

