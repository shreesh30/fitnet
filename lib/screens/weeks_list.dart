import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/widgets/weeks_list_items.dart';
import 'package:fitnet/components/common_scaffold.dart';
import 'package:fitnet/size_config.dart';
import 'package:fitnet/screens/days_list.dart';

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
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = getWeekList();
  }

  Future getWeekList() async {
    List items;
    List weeksList = [];
    await FirebaseDatabase.instance
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
        text: widget.workoutName,
        body: WeeksListItems(future: _future, widget: widget));
  }
}

