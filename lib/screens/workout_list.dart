import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnet/screens/workout_program.dart';
import 'package:fitnet/services/workout_title.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/components/bottom_nav_bar.dart';
import 'package:firebase_database/firebase_database.dart';

class WorkoutList extends StatefulWidget {
  static const String id = 'workout_list';
  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  final _firestore = Firestore.instance;
  List finalWorkoutList;

  @override
  void initState() {
    super.initState();
    getWorkoutList();
  }

  List getWorkoutList() {
    List items;
    List workoutList = [];
    FirebaseDatabase.instance
        .reference()
        .child('workout')
        .child('workout list')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      items = values.keys.toList();
      for (int i = 0; i < items.length; i++) {
        String workout = items[i];
        var newItem = workout;
        workoutList.add(newItem);
      }
      if (this.mounted) {
        setState(() {
          finalWorkoutList = workoutList;
        });
      }
    });
    return finalWorkoutList;
  }

  @override
  Widget build(BuildContext context) {
    getWorkoutList();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Workout List',
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF0F0F0F),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
          child: ListView.separated(
              separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.fromLTRB(SizeConfig.widthMultiplier * 7,
                      0, SizeConfig.widthMultiplier * 7, 0),
                  child: Divider(color: Color(0xFF8B8A8D))),
              itemCount: finalWorkoutList != null ? finalWorkoutList.length : 0,
              itemBuilder: (context, index) {
                if (finalWorkoutList != null) {
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
                          return WorkoutProgram(
                            workoutProgramName:
                                finalWorkoutList[index].toString(),
                          );
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
                                  finalWorkoutList[index].toString(),
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
        bottomNavigationBar: BottomNavBar());
  }
}

// getWorkoutList(){
//   dbref.once().then((DataSnapshot snapshot){
//     Map<dynamic,dynamic> values=snapshot.value;
//     values.forEach((key, value) {print(values.keys);});
//   });
// }

// Future getWorkoutList() async{
//   QuerySnapshot qn=await _firestore.collection('workout list').getDocuments();
//   final List<DocumentSnapshot> documents =qn.documents;
//   documents.forEach((data) {print(data.documentID);});

//   return documents;
// }

//   List<TextSpan> getWorkoutList(){
//   List items;
//   List<TextSpan> workoutList=[];
//   FirebaseDatabase.instance.reference().child('workout').child('workout list').once().then((DataSnapshot snapshot){
//     Map<dynamic,dynamic> values=snapshot.value;
//     items=values.keys.toList();
//     for(int i=0;i<items.length;i++){
//         String workout=items[i];
//         var newItem=TextSpan(text: workout);
//         workoutList.add(newItem);
//     }
//     if(this.mounted){
//            setState(() {
//       finalWorkoutList=workoutList;
//     });
//     }

//     return workoutList;
//   });
//   return finalWorkoutList;
// }
