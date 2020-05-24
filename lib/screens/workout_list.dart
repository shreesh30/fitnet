import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/components/bottom_nav_bar.dart';

class WorkoutList extends StatefulWidget {
  static const String id = 'workout_list';
  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Workout List',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: SizeConfig.textMultiplier * 3,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
