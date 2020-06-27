
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitnet/widgets/mental_health_list_items.dart';
import 'package:fitnet/size_config.dart';
import 'package:fitnet/screens/mental_health_selected_option.dart';

class MentalHealthList extends StatefulWidget {
  static const String id = 'mental_health_list';

  @override
  _MentalHealthListState createState() => _MentalHealthListState();
}

class _MentalHealthListState extends State<MentalHealthList> {
  List finalMentalHealthList;
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = getMentalHealthList();
  }

  Future getMentalHealthList() async {
    List items;
    List mentalHealthList = [];
    await FirebaseDatabase.instance
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
    return finalMentalHealthList;
  }

  @override
  Widget build(BuildContext context) {
    // return CommonScaffold(
    //   appbar: true,
    //   automaticallyImplyLeading: false,
    //   text: 'Mental Health',
    //   body: MentalHealthListItems(future: _future),
    // );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          // leading: IconButton(
          //   padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
          //   icon: Icon(
          //     Icons.arrow_back_ios,
          //     size: SizeConfig.heightMultiplier * 3,
          //     color: Color(0xFFFD5739),
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   }),
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Mental Health',
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
      body: MentalHealthListItems(future: _future),
    );
  }
}

