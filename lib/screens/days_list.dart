import 'package:fitnet/components/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/widgets/days_list_items.dart';

class DaysList extends StatefulWidget {
  DaysList({this.weekNumber, this.workoutProgramName, this.workoutName});

  static const String id = 'days_list';
  final String weekNumber;
  final String workoutName;
  final String workoutProgramName;

  @override
  _DaysListState createState() => _DaysListState();
}

class _DaysListState extends State<DaysList> {
  List finalDaysList;

  @override
  void initState() {
    super.initState();
    getDaysList();
  }

  List getDaysList() {
    List items;
    List daysList = [];
    FirebaseDatabase.instance
        .reference()
        .child('workout')
        .child('workout list')
        .child(widget.workoutProgramName)
        .child(widget.workoutName)
        .child(widget.weekNumber)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      items = values.keys.toList();
      for (int i = 0; i < items.length; i++) {
        String workout = items[i];
        var newItem = workout;
        daysList.add(newItem);
      }
      if (this.mounted) {
        setState(() {
          finalDaysList = daysList;
        });
      }
    });
    return finalDaysList;
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(automaticallyImplyLeading: true,text: widget.weekNumber,body:DaysListItems(finalDaysList: finalDaysList, widget: widget),);
  }
}

