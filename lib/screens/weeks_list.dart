import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/widgets/weeks_list_items.dart';
import 'package:fitnet/components/common_scaffold.dart';

class WeeksList extends StatefulWidget {
  WeeksList({this.workoutName, this.workoutProgramName});

  static const String id = 'weeks_list';
  final String workoutName;
  final String workoutProgramName;

  @override
  _WeeksListState createState() => _WeeksListState();
}

class _WeeksListState extends State<WeeksList> {
  List finalWeeksList;

  @override
  void initState() {
    super.initState();
    getWeekList();
  }

  List getWeekList() {
    List items;
    List weeksList = [];
    FirebaseDatabase.instance
        .reference()
        .child('workout')
        .child('workout list')
        .child(widget.workoutProgramName)
        .child(widget.workoutName)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      items = values.keys.toList();
      for (int i = 0; i < items.length; i++) {
        String workout = items[i];
        var newItem = workout;
        weeksList.add(newItem);
      }
      if (this.mounted) {
        setState(() {
          finalWeeksList = weeksList;
        });
      }
    });
    return finalWeeksList;
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      automaticallyImplyLeading: true,
      text:widget.workoutName ,
      body:  WeeksListItems(finalWeeksList: finalWeeksList, widget: widget,),
    );
  }
}

