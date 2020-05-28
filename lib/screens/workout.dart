import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:firebase_database/firebase_database.dart';

class Workout extends StatefulWidget {
  Workout(
      {this.dayNumber,
      this.weekNumber,
      this.workoutProgramName,
      this.workoutName});

  static const String id = 'workout';
  final String dayNumber;
  final String weekNumber;
  final String workoutName;
  final String workoutProgramName;
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  List finalWorkoutToPerform;

  @override
  void initState() {
    super.initState();
    getWorkou();
  }

  List getWorkou() {
    List items;
    List workoutToPerform = [];
    FirebaseDatabase.instance
        .reference()
        .child('workout')
        .child('workout list')
        .child(widget.workoutProgramName)
        .child(widget.workoutName)
        .child(widget.weekNumber)
        .child(widget.dayNumber)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      items = values.keys.toList();
      for (int i = 0; i < items.length; i++) {
        String workout = items[i];
        var newItem = workout;
        workoutToPerform.add(newItem);
      }
      if (this.mounted) {
        setState(() {
          finalWorkoutToPerform = workoutToPerform;
        });
      }
    });
    return finalWorkoutToPerform;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.dayNumber,
          style: TextStyle(
              fontFamily: 'CopperPlate',
              fontSize: SizeConfig.textMultiplier * 3,
              fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(
            color: Color(0xFFFD5739), size: SizeConfig.widthMultiplier * 10),
        backgroundColor: Color(0xFF0F0F0F),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
        child: ListView.separated(
            separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.fromLTRB(SizeConfig.widthMultiplier * 7, 0,
                    SizeConfig.widthMultiplier * 7, 0),
                child: Divider(color: Color(0xFF8B8A8D))),
            itemCount: finalWorkoutToPerform != null
                ? finalWorkoutToPerform.length
                : 0,
            itemBuilder: (context, index) {
              if (finalWorkoutToPerform != null) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.widthMultiplier * 4,
                      SizeConfig.heightMultiplier * 2.5,
                      SizeConfig.widthMultiplier * 4,
                      SizeConfig.widthMultiplier * 2.5),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.widthMultiplier * 5,
                        0,
                        SizeConfig.widthMultiplier * 5,
                        0),
                    height: 50,
                    color: Color(0xff0f0f0f),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFFFD5739),
                              size: SizeConfig.heightMultiplier * 4,
                            ),
                            Text(
                              finalWorkoutToPerform[index].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 3),
                            ),
                          ],
                        )),
                  ),
                );
              } else {
                return Text('Loading');
              }
            }),
      ),
    );
  }
}
