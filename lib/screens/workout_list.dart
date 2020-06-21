import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/widgets/workout_list_items.dart';


class WorkoutList extends StatefulWidget {
  static const String id = 'workout_list';
  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  List finalWorkoutList;
  Future _future;
  @override
  void initState() {
    super.initState();
    _future = getWorkoutList();
  }

  getData() async {
    return await getWorkoutList();
  }

  Future getWorkoutList() async {
    List items;
    List workoutList = [];
    await FirebaseDatabase.instance
        .reference()
        .child('workout')
        .child('workout list')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      items = values.keys.toList();
      for (int i = 0; i < items.length; i++) {
        String workout = items[i];
        var newItem = workout;
        workoutList.add(newItem);
      }
      if (this.mounted) {
        setState(() {
          finalWorkoutList = workoutList;
        });
      }
    });
    return finalWorkoutList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Workout List',
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
      body: WorkoutListItems(future: _future),
    );
  }
}

