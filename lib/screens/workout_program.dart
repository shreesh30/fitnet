import 'package:flutter/material.dart';

class WorkoutProgram extends StatefulWidget {

  static const String id='workout_program';
  @override
  _WorkoutProgramState createState() => _WorkoutProgramState();
}

class _WorkoutProgramState extends State<WorkoutProgram> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text('Workout Programs'),
    );
  }
}