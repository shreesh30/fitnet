import 'package:fitnet/components/bottom_nav_bar.dart';
import 'package:fitnet/components/common_scaffold.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class MealTracker extends StatefulWidget {
  static const String id='meal_tracker';
  @override
  _MealTrackerState createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  @override
  Widget build(BuildContext context) {
    // return CommonScaffold(
    //   appbar: true,
    //   automaticallyImplyLeading: false,
    //   text: 'Today',
      
    // );
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Today',
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
    );
  }
}