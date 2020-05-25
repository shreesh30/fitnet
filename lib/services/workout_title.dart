// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class WorkoutTitle{

//   String workoutListId;

//   WorkoutTitle(this.workoutListId);
// }

// List<TextSpan> workoutTitleList=[];

//  List getWorkoutList() {
     
//      DatabaseReference workoutListReference = FirebaseDatabase.instance
//         .reference()
//         .child('workout').child('workout list');

//     workoutListReference.once().then(
//       (DataSnapshot snap) {
//         var workoutListKeys=snap.value.keys;
//         var data=snap.value;
          
       

//         for(var workoutListKey in workoutListKeys){
//           var title=TextSpan(text:WorkoutTitle(workoutListKey).toString());

//           workoutTitleList.add(title);
           
//         }
//         return workoutTitleList;
//       });
//       print(workoutTitleList);
//     return workoutTitleList;
//   }


import 'package:firebase_database/firebase_database.dart';
 
class WorkoutList {
  String _id;
  // String _title;
  // String _description;
 
  WorkoutList(this._id);
 
  WorkoutList.map(dynamic obj) {
    this._id = obj['id'];
    // this._title = obj['title'];
    // this._description = obj['description'];
  }
 
  String get id => _id;
  // String get title => _title;
  // String get description => _description;
 
  WorkoutList.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    // _title = snapshot.value['title'];
    // _description = snapshot.value['description'];
  }
}