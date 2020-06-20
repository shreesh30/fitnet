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
  Future _future;

  @override
  void initState() {
    super.initState();
    // getWorkout();
    // getVideo();
    // getSets();
    // getReps();
    // getDescription();
    _future = getData();
  }

  Future getData() async {
    return [
      await getWorkout(),
      await getSets(),
      await getReps(),
      await getDescription(),
      await getVideo()
    ];
  }

  Future getWorkout() async {
    List items;
    List workoutToPerform = [];
    await FirebaseDatabase.instance
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

  Future getVideo() async {
    List urlList = [];
    await FirebaseDatabase.instance
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
    return finalUrlList;
  }

  Future getSets() async {
    List setsList = [];
    await FirebaseDatabase.instance
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
    return finalSetsList;
  }

  Future getReps() async {
    List repsList = [];
    await FirebaseDatabase.instance
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
    return finalRepsList;
  }

  Future getDescription() async {
    List descriptionList = [];
    await FirebaseDatabase.instance
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
    return finalDescriptionList;
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      automaticallyImplyLeading: true,
      text: widget.dayNumber,
      // body: Padding(
      //   padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
      //   child: ListView.separated(
      //       separatorBuilder: (context, index) => Padding(
      //             padding: EdgeInsets.symmetric(
      //                 vertical: 0, horizontal: SizeConfig.widthMultiplier * 4),
      //             child: Divider(color: Color(0xff8B8A8D)),
      //           ),
      //       itemCount: finalWorkoutToPerform != null
      //           ? finalWorkoutToPerform.length
      //           : 0,
      //       itemBuilder: (context, index) {
      //         if (finalWorkoutToPerform != null) {
      //           return Padding(
      //             padding: EdgeInsets.fromLTRB(
      //                 SizeConfig.widthMultiplier * 4,
      //                 SizeConfig.heightMultiplier,
      //                 SizeConfig.widthMultiplier * 4,
      //                 SizeConfig.widthMultiplier * 2),
      //             child: Theme(
      //               data: Theme.of(context)
      //                   .copyWith(dividerColor: Colors.transparent),
      //               child: custom.ExpansionTile(
      //                 iconColor: Color(0xFFFD5739),
      //                 headerBackgroundColor: Color(0xff0F0F0F),
      //                 title: Row(
      //                   children: <Widget>[
      //                     IconButton(
      //                       onPressed: () {
      //                         setState(() {
      //                           url = finalUrlList[index];
      //                         });
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => VideoScreen(
      //                               url: url,
      //                             ),
      //                           ),
      //                         );
      //                       },
      //                       icon: Icon(Icons.play_circle_outline),
      //                       color: Color(0xFFFD5739),
      //                       iconSize: SizeConfig.heightMultiplier * 4,
      //                     ),
      //                     SizedBox(
      //                       width: SizeConfig.widthMultiplier * 5,
      //                     ),
      //                     Text(
      //                       finalWorkoutToPerform[index].toString(),
      //                       style: TextStyle(
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.w300,
      //                           fontFamily: 'Roboto',
      //                           fontSize: SizeConfig.textMultiplier * 3),
      //                       textAlign: TextAlign.left,
      //                     ),
      //                   ],
      //                 ),
      //                 children: <Widget>[
      //                   Padding(
      //                     padding: EdgeInsets.symmetric(
      //                         vertical: SizeConfig.heightMultiplier,
      //                         horizontal: SizeConfig.widthMultiplier),
      //                     child: RichText(
      //                       text: TextSpan(
      //                         children: <TextSpan>[
      //                           finalSetsList[index] == null ||
      //                                   finalSetsList[index] == " " ||
      //                                   finalSetsList[index] == '' ||
      //                                   finalSetsList[index] == ' ' ||
      //                                   finalSetsList[index] == ""
      //                               ? TextSpan(text: " ")
      //                               : TextSpan(
      //                                   text:
      //                                       'Sets : ${finalSetsList[index].toString()} ',
      //                                   style: TextStyle(
      //                                       fontFamily: 'Roboto',
      //                                       fontSize:
      //                                           SizeConfig.textMultiplier * 2.5,
      //                                       fontWeight: FontWeight.w300)),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.symmetric(
      //                         vertical: SizeConfig.heightMultiplier,
      //                         horizontal: SizeConfig.widthMultiplier),
      //                     child: RichText(
      //                       text: TextSpan(
      //                         children: <TextSpan>[
      //                           finalRepsList[index] == null ||
      //                                   finalRepsList[index] == " " ||
      //                                   finalRepsList[index] == '' ||
      //                                   finalRepsList[index] == ' ' ||
      //                                   finalRepsList[index] == ""
      //                               ? TextSpan(text: " ")
      //                               : TextSpan(
      //                                   text:
      //                                       'Reps : ${finalRepsList[index].toString()} ',
      //                                   style: TextStyle(
      //                                       fontFamily: 'Roboto',
      //                                       fontSize:
      //                                           SizeConfig.textMultiplier * 2.5,
      //                                       fontWeight: FontWeight.w300)),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.symmetric(
      //                         vertical: SizeConfig.heightMultiplier,
      //                         horizontal: SizeConfig.widthMultiplier),
      //                     child: RichText(
      //                       text: TextSpan(
      //                         children: <TextSpan>[
      //                           finalDescriptionList[index] == null ||
      //                                   finalDescriptionList[index] == " " ||
      //                                   finalDescriptionList[index] == '' ||
      //                                   finalDescriptionList[index] == ' ' ||
      //                                   finalDescriptionList[index] == ""
      //                               ? TextSpan(text: " ")
      //                               : TextSpan(
      //                                   text:
      //                                       'Description : ${finalDescriptionList[index].toString()}',
      //                                   style: TextStyle(
      //                                       fontFamily: 'Roboto',
      //                                       fontSize:
      //                                           SizeConfig.textMultiplier * 2.5,
      //                                       fontWeight: FontWeight.w300),
      //                                 ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         } else {
      //           return Text('Loading');
      //         }
      //       }),
      // ),
      body: Padding(
        padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.none)
                    return Center(child: new CircularProgressIndicator());
                  else
                    return Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: SizeConfig.widthMultiplier * 4),
                                child: Divider(color: Color(0xff8B8A8D)),
                              ),
                          itemCount: snapshot.data[0] != null
                              ? snapshot.data[0].length
                              : 0,
                          itemBuilder: (context, index) {
                            if (snapshot.data[0] != null) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                    SizeConfig.widthMultiplier * 4,
                                    SizeConfig.heightMultiplier,
                                    SizeConfig.widthMultiplier * 4,
                                    SizeConfig.widthMultiplier * 2),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: custom.ExpansionTile(
                                    iconColor: Color(0xFFFD5739),
                                    headerBackgroundColor: Color(0xff0F0F0F),
                                    title: Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              url = snapshot.data[4][index];
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoScreen(
                                                  url: url,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.play_circle_outline),
                                          color: Color(0xFFFD5739),
                                          iconSize:
                                              SizeConfig.heightMultiplier * 4,
                                        ),
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier * 5,
                                        ),
                                        Text(
                                          finalWorkoutToPerform[index]
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      3),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier,
                                            horizontal:
                                                SizeConfig.widthMultiplier),
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              snapshot.data[1][index] == null ||
                                                      snapshot.data[1][index] ==
                                                          " " ||
                                                      snapshot.data[1][index] ==
                                                          '' ||
                                                      snapshot.data[1][index] ==
                                                          ' ' ||
                                                      snapshot.data[1][index] ==
                                                          ""
                                                  ? TextSpan(text: " ")
                                                  : TextSpan(
                                                      text:
                                                          'Sets : ${snapshot.data[1][index].toString()} ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.5,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier,
                                            horizontal:
                                                SizeConfig.widthMultiplier),
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              snapshot.data[2][index] == null ||
                                                      snapshot.data[2][index] ==
                                                          " " ||
                                                      snapshot.data[2][index] ==
                                                          '' ||
                                                      snapshot.data[2][index] ==
                                                          ' ' ||
                                                      snapshot.data[2][index] ==
                                                          ""
                                                  ? TextSpan(text: " ")
                                                  : TextSpan(
                                                      text:
                                                          'Reps : ${snapshot.data[2][index].toString()} ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.5,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier,
                                            horizontal:
                                                SizeConfig.widthMultiplier),
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              snapshot.data[3][index] == null ||
                                                      snapshot.data[3][index] ==
                                                          " " ||
                                                      snapshot.data[3][index] ==
                                                          '' ||
                                                      snapshot.data[3][index] ==
                                                          ' ' ||
                                                      snapshot.data[3][index] ==
                                                          ""
                                                  ? TextSpan(text: " ")
                                                  : TextSpan(
                                                      text:
                                                          'Description : ${snapshot.data[3][index].toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2.5,
                                                          fontWeight:
                                                              FontWeight.w300),
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
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    );
              }
            }),
      ),
    );
  }
}

//  body: Padding(
//         padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
//         child: ListView.separated(
//             separatorBuilder: (context, index) => Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: 0, horizontal: SizeConfig.widthMultiplier * 4),
//                   child: Divider(color: Color(0xff8B8A8D)),
//                 ),
//             itemCount: finalWorkoutToPerform != null
//                 ? finalWorkoutToPerform.length
//                 : 0,
//             itemBuilder: (context, index) {
//               if (finalWorkoutToPerform != null) {
//                 return Padding(
//                   padding: EdgeInsets.fromLTRB(
//                       SizeConfig.widthMultiplier * 4,
//                       SizeConfig.heightMultiplier,
//                       SizeConfig.widthMultiplier * 4,
//                       SizeConfig.widthMultiplier * 2),
//                   child: Theme(
//                     data: Theme.of(context)
//                         .copyWith(dividerColor: Colors.transparent),
//                     child: custom.ExpansionTile(
//                       iconColor: Color(0xFFFD5739),
//                       headerBackgroundColor: Color(0xff0F0F0F),
//                       title: Row(
//                         children: <Widget>[
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 url = finalUrlList[index];
//                               });
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                     url: url,
//                                   ),
//                                 ),
//                               );
//                             },
//                             icon: Icon(Icons.play_circle_outline),
//                             color: Color(0xFFFD5739),
//                             iconSize: SizeConfig.heightMultiplier * 4,
//                           ),
//                           SizedBox(
//                             width: SizeConfig.widthMultiplier * 5,
//                           ),
//                           Text(
//                             finalWorkoutToPerform[index].toString(),
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w300,
//                                 fontFamily: 'Roboto',
//                                 fontSize: SizeConfig.textMultiplier * 3),
//                             textAlign: TextAlign.left,
//                           ),
//                         ],
//                       ),
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: SizeConfig.heightMultiplier,
//                               horizontal: SizeConfig.widthMultiplier),
//                           child: RichText(
//                             text: TextSpan(
//                               children: <TextSpan>[
//                                 finalSetsList[index] == null ||
//                                         finalSetsList[index] == " " ||
//                                         finalSetsList[index] == '' ||
//                                         finalSetsList[index] == ' ' ||
//                                         finalSetsList[index] == ""
//                                     ? TextSpan(text: " ")
//                                     : TextSpan(
//                                         text:
//                                             'Sets : ${finalSetsList[index].toString()} ',
//                                         style: TextStyle(
//                                             fontFamily: 'Roboto',
//                                             fontSize:
//                                                 SizeConfig.textMultiplier * 2.5,
//                                             fontWeight: FontWeight.w300)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: SizeConfig.heightMultiplier,
//                               horizontal: SizeConfig.widthMultiplier),
//                           child: RichText(
//                             text: TextSpan(
//                               children: <TextSpan>[
//                                 finalRepsList[index] == null ||
//                                         finalRepsList[index] == " " ||
//                                         finalRepsList[index] == '' ||
//                                         finalRepsList[index] == ' ' ||
//                                         finalRepsList[index] == ""
//                                     ? TextSpan(text: " ")
//                                     : TextSpan(
//                                         text:
//                                             'Reps : ${finalRepsList[index].toString()} ',
//                                         style: TextStyle(
//                                             fontFamily: 'Roboto',
//                                             fontSize:
//                                                 SizeConfig.textMultiplier * 2.5,
//                                             fontWeight: FontWeight.w300)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: SizeConfig.heightMultiplier,
//                               horizontal: SizeConfig.widthMultiplier),
//                           child: RichText(
//                             text: TextSpan(
//                               children: <TextSpan>[
//                                 finalDescriptionList[index] == null ||
//                                         finalDescriptionList[index] == " " ||
//                                         finalDescriptionList[index] == '' ||
//                                         finalDescriptionList[index] == ' ' ||
//                                         finalDescriptionList[index] == ""
//                                     ? TextSpan(text: " ")
//                                     : TextSpan(
//                                         text:
//                                             'Description : ${finalDescriptionList[index].toString()}',
//                                         style: TextStyle(
//                                             fontFamily: 'Roboto',
//                                             fontSize:
//                                                 SizeConfig.textMultiplier * 2.5,
//                                             fontWeight: FontWeight.w300),
//                                       ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               } else {
//                 return Text('Loading');
//               }
//             }),
//       ),
