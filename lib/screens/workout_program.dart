import 'package:fitnet/screens/weeks_list.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/components/bottom_nav_bar.dart';

class WorkoutProgram extends StatefulWidget {
  WorkoutProgram({this.workoutProgramName});

  static const String id = 'workout_program';
  final String workoutProgramName;
  @override
  _WorkoutProgramState createState() => _WorkoutProgramState();
}

class _WorkoutProgramState extends State<WorkoutProgram> {
  List finalWorkoutProgram;


   @override
  void initState() {
    super.initState();
    getWorkoutProgram();
  }


  List getWorkoutProgram() {
    List items;
    List workoutProgram = [];
    FirebaseDatabase.instance
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.workoutProgramName,
          style: TextStyle(
              fontFamily: 'CopperPlate',
              fontSize: SizeConfig.textMultiplier * 3,
              fontWeight: FontWeight.bold),
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
                  padding: EdgeInsets.fromLTRB(SizeConfig.widthMultiplier * 7,
                      0, SizeConfig.widthMultiplier * 7, 0),
                  child: Divider(color: Color(0xFF8B8A8D))),
              itemCount: finalWorkoutProgram != null ? finalWorkoutProgram.length : 0,
              itemBuilder: (context, index) {
                if (finalWorkoutProgram != null) {
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
                          return WeeksList(workoutName:finalWorkoutProgram[index].toString() ,workoutProgramName: widget.workoutProgramName,);
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
                                  finalWorkoutProgram[index].toString(),
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
