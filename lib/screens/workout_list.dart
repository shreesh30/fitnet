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
          // leading: IconButton(
          //   padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
          //   icon: Icon(
          //     Icons.arrow_back_ios,
          //     size: SizeConfig.heightMultiplier * 3,
          //     color: Color(0xFFFD5739),
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   }),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Workout List',
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
      body: WorkoutListItems(future: _future),
    );
  }
}

