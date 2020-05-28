import 'package:fitnet/screens/days_list.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/components/bottom_nav_bar.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.workoutName,
          style: TextStyle(
              fontFamily: 'CopperPlate',
              fontSize: SizeConfig.textMultiplier * 3,
              fontWeight: FontWeight.bold),
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
            itemCount: finalWeeksList != null ? finalWeeksList.length : 0,
            itemBuilder: (context, index) {
              if (finalWeeksList != null) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.widthMultiplier * 4,
                      SizeConfig.heightMultiplier * 2.5,
                      SizeConfig.widthMultiplier * 4,
                      SizeConfig.widthMultiplier * 2.5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DaysList(weekNumber: finalWeeksList[index].toString(),workoutName: widget.workoutName,workoutProgramName: widget.workoutProgramName,);
                      }));
                    },
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                finalWeeksList[index].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Roboto',
                                    fontSize: SizeConfig.textMultiplier * 3),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Color(0xFFFD5739),
                                size: SizeConfig.heightMultiplier * 4,
                              )
                            ],
                          )),
                    ),
                  ),
                );
              } else {
                return Text('Loading');
              }
            }),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
