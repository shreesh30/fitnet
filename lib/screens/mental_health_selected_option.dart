import 'package:fitnet/components/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:firebase_database/firebase_database.dart';

class MentalHealthSelectedOption extends StatefulWidget {
  MentalHealthSelectedOption({this.selectedOption});

  static const String id = 'mental_health_selected_option';
  final String selectedOption;

  @override
  _MentalHealthSelectedOptionState createState() =>
      _MentalHealthSelectedOptionState();
}

class _MentalHealthSelectedOptionState
    extends State<MentalHealthSelectedOption> {
  List finalOptionsList;

  @override
  initState() {
    super.initState();
    getOptions();
  }

  List getOptions() {
    List items;
    List options = [];
    FirebaseDatabase.instance
        .reference()
        .child('mental health')
        .child(widget.selectedOption)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      items = values.keys.toList();
      for (int i = 0; i < items.length; i++) {
        String option = items[i];
        var newItem = option;
        options.add(newItem);
      }
      if (this.mounted) {
        setState(() {
          finalOptionsList = options;
        });
      }
    });
    return finalOptionsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.selectedOption,
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
        padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
        child: ListView.separated(
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0, horizontal: SizeConfig.widthMultiplier * 4),
            child: Divider(color: Color(0xff8B8A8D)),
          ),
          itemCount: finalOptionsList != null ? finalOptionsList.length : 0,
          itemBuilder: (context, index) {
            if (finalOptionsList != null) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.widthMultiplier * 4,
                      SizeConfig.heightMultiplier,
                      SizeConfig.widthMultiplier * 4,
                      SizeConfig.widthMultiplier * 2),
                  child: Card(
                    color: Color(0xff0f0f0f),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.play_circle_outline),
                          color: Color(0xFFFD5739),
                          iconSize: SizeConfig.heightMultiplier * 4,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 5,
                        ),
                        Text(finalOptionsList[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Roboto',
                                fontSize: SizeConfig.textMultiplier * 3))
                      ],
                    ),
                  ));
            } else {
              return Text('Loading');
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
