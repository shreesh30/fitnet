
import 'package:fitnet/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
  List finalUrlList;


  @override
  void initState() {
    super.initState();
    getWorkout();
    getVideo();

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                    padding: EdgeInsets.fromLTRB(SizeConfig.widthMultiplier * 5,
                        0, SizeConfig.widthMultiplier * 5, 0),
                    height: 50,
                    color: Color(0xff0f0f0f),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed:(){
                                setState(() {
                            url = finalUrlList[index];
                          });
                          print(url);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoScreen(url: url,),),);
        
                          } ,
                          icon:Icon(Icons.play_circle_outline),
                          color: Color(0xFFFD5739),
                          iconSize: SizeConfig.heightMultiplier * 4,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 5,
                        ),
                        Text(
                          finalWorkoutToPerform[index].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Roboto',
                              fontSize: SizeConfig.textMultiplier * 3),
                          textAlign: TextAlign.left,
                        ),
                        Expanded(
                            child: SizedBox(
                                width: SizeConfig.widthMultiplier * 25)),
                        Icon(
                          FontAwesomeIcons.ellipsisV,
                          color: Color(0xFFFD5739),
                          size: SizeConfig.heightMultiplier * 2.5,
                        )
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
