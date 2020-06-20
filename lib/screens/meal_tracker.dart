import 'package:fitnet/components/common_scaffold.dart';
import 'package:flutter/material.dart';

class MealTracker extends StatefulWidget {
  static const String id='meal_tracker';
  @override
  _MealTrackerState createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      automaticallyImplyLeading: false,
      text: 'Today',
    );
  }
}