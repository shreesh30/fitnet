import 'package:fitnet/components/common_scaffold.dart';
import 'package:fitnet/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/components/custom_expansion_tile.dart' as custom;

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
  String url = " ";
  String sets = "";
  String reps = "";
  String description = "";
  List finalUrlList;
  List finalSetsList;
  List finalRepsList;
  List finalDescriptionList;

  @override
  void initState() {
    super.initState();
    getWorkout();
    getVideo();
    getSets();
    getReps();
    getDescription();
  }

  List getWorkout() {
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

  void getVideo() {
    List urlList = [];
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
      values.forEach((key, value) async {
        url = value["video"];
        urlList.add(url);
      });
      setState(() {
        finalUrlList = urlList;
      });
    });
  }

  void getSets() {
    List setsList = [];
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
      values.forEach((key, value) async {
        sets = value["sets"].toString();
        setsList.add(sets);
      });
      if (this.mounted) {
        setState(() {
          finalSetsList = setsList;
        });
      }
    });
  }

  void getReps() {
    List repsList = [];
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
      values.forEach((key, value) async {
        reps = value["reps"].toString();
        repsList.add(reps);
      });
      if (this.mounted) {
        setState(() {
          finalRepsList = repsList;
        });
      }
    });
  }

  void getDescription() {
    List descriptionList = [];
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
      values.forEach((key, value) async {
        description = value["description"];
        descriptionList.add(description);
      });
      if (this.mounted) {
        setState(() {
          finalDescriptionList = descriptionList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      automaticallyImplyLeading: true,
      text:  widget.dayNumber,
      body: Padding(
        padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
        child: ListView.separated(
            separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: SizeConfig.widthMultiplier * 4),
                  child: Divider(color: Color(0xff8B8A8D)),
                ),
            itemCount: finalWorkoutToPerform != null
                ? finalWorkoutToPerform.length
                : 0,
            itemBuilder: (context, index) {
              if (finalWorkoutToPerform != null) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.widthMultiplier * 4,
                      SizeConfig.heightMultiplier,
                      SizeConfig.widthMultiplier * 4,
                      SizeConfig.widthMultiplier * 2),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: custom.ExpansionTile(
                      iconColor: Color(0xFFFD5739),
                      headerBackgroundColor: Color(0xff0F0F0F),
                      title: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              setState(() {
                                url = finalUrlList[index];
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoScreen(
                                    url: url,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.play_circle_outline),
                            color: Color(0xFFFD5739),
                            iconSize: SizeConfig.heightMultiplier * 4,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 5,
                          ),
                          Text(
                            finalWorkoutToPerform[index].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Roboto',
                                fontSize: SizeConfig.textMultiplier * 3),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier,
                              horizontal: SizeConfig.widthMultiplier),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                finalSetsList[index] == null ||
                                        finalSetsList[index] == " " ||
                                        finalSetsList[index] == '' ||
                                        finalSetsList[index] == ' ' ||
                                        finalSetsList[index] == ""
                                    ? TextSpan(text: " ")
                                    : TextSpan(
                                        text:
                                            'Sets : ${finalSetsList[index].toString()} ',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier,
                              horizontal: SizeConfig.widthMultiplier),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                finalRepsList[index] == null ||
                                        finalRepsList[index] == " " ||
                                        finalRepsList[index] == '' ||
                                        finalRepsList[index] == ' ' ||
                                        finalRepsList[index] == ""
                                    ? TextSpan(text: " ")
                                    : TextSpan(
                                        text:
                                            'Reps : ${finalRepsList[index].toString()} ',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.heightMultiplier,
                              horizontal: SizeConfig.widthMultiplier),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                finalDescriptionList[index] == null ||
                                        finalDescriptionList[index] == " " ||
                                        finalDescriptionList[index] == '' ||
                                        finalDescriptionList[index] == ' ' ||
                                        finalDescriptionList[index] == ""
                                    ? TextSpan(text: " ")
                                    : TextSpan(
                                        text:
                                            'Description : ${finalDescriptionList[index].toString()}',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w300),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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


