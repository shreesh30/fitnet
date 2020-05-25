import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<TextSpan> finalWorkoutList;
   

  @override
  void initState() {
    super.initState();
    getWorkoutList();
  }


  List<TextSpan> getWorkoutList(){
  List items;
  List<TextSpan> workoutList=[];
  FirebaseDatabase.instance.reference().child('workout').child('workout list').once().then((DataSnapshot snapshot){
    Map<dynamic,dynamic> values=snapshot.value;
    items=values.keys.toList();
    for(int i=0;i<items.length;i++){
        String workout=items[i];
        var newItem=TextSpan(text: workout);
        workoutList.add(newItem);
    }
    if(this.mounted){
           setState(() {
      finalWorkoutList=workoutList;
    });
    }
 
    return workoutList;
  });
  return finalWorkoutList;
}


  @override
  Widget build(BuildContext context) {
    getWorkoutList();
    return Scaffold(
     appBar: AppBar(
        title: Text(
          'Workout List',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 3,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RichText(text: TextSpan(
              children: finalWorkoutList
            ))
          ],
        ),
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

