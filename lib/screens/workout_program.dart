import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/widgets/workout_program_items.dart';
import 'package:fitnet/components/common_scaffold.dart';
import 'package:fitnet/screens/weeks_list.dart';

class WorkoutProgram extends StatefulWidget {
  WorkoutProgram({this.workoutProgramName});

  static const String id = 'workout_program';
  final String workoutProgramName;
  @override
  _WorkoutProgramState createState() => _WorkoutProgramState();
}

class _WorkoutProgramState extends State<WorkoutProgram> {
  List finalWorkoutProgram;
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = getWorkoutProgram();
  }

  Future getWorkoutProgram() async {
    List items;
    List workoutProgram = [];
    await FirebaseDatabase.instance
        .reference()
        .child('workout')
        .child('workout list')
        .child(widget.workoutProgramName)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      items = values.keys.toList();
      for (int i = 0; i < items.length; i++) {
        String workout = items[i];
        var newItem = workout;
        workoutProgram.add(newItem);
      }
      if (this.mounted) {
        setState(() {
          finalWorkoutProgram = workoutProgram;
        });
      }
    });
    return finalWorkoutProgram;
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      automaticallyImplyLeading: true,
      text: widget.workoutProgramName,
      body: WorkoutProgramItems(
          future: _future,
          widget: widget,
          finalWorkoutProgram: finalWorkoutProgram),
    );
  }
}
