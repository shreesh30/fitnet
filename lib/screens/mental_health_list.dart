import 'package:fitnet/components/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/widgets/mental_health_list_items.dart';

class MentalHealthList extends StatefulWidget {
  static const String id='mental_health_list';
  
  @override
  _MentalHealthListState createState() => _MentalHealthListState();
}

class _MentalHealthListState extends State<MentalHealthList> {
  List finalMentalHealthList;


  @override
  void initState() {
    super.initState();
    getMentalHealthList();
  }

  void getMentalHealthList(){
     List items;
    List mentalHealthList = [];
    FirebaseDatabase.instance
        .reference()
        .child('mental health')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      items = values.keys.toList();
      for (int i = 0; i < items.length; i++) {
        String mentalHealth = items[i];
        var newItem = mentalHealth;
        mentalHealthList.add(newItem);
      }
      if (this.mounted) {
        setState(() {
          finalMentalHealthList = mentalHealthList;
        });
      }
    });
   
  }


  @override
  Widget build(BuildContext context) {
    return CommonScaffold(automaticallyImplyLeading: false,text: 'Mental Health',body:  MentalHealthListItems(finalMentalHealthList: finalMentalHealthList),);
  }
}


