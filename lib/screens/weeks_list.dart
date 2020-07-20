import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/widgets/weeks_list_items.dart';
import 'package:fitnet/size_config.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
            icon: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.heightMultiplier * 3,
              color: Color(0xFFFD5739),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.workoutName,
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
      body: WeeksListItems(future: _future, widget: widget),
    );
  }
}
