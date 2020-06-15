import 'package:fitnet/components/common_scaffold.dart';
import 'package:fitnet/screens/audio_screen.dart';
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
  String url = " ";
  List finalOptionsList;
  List finalUrlList;

  @override
  initState() {
    super.initState();
    getOptions();
    getAudio();
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

  void getAudio() {
    List urlList = [];
    FirebaseDatabase.instance
        .reference()
        .child('mental health')
        .child(widget.selectedOption)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) async {
        url = value["audio"];
        urlList.add(url);
      });
      if (this.mounted) {
        setState(() {
          finalUrlList = urlList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      automaticallyImplyLeading: true,
      text: widget.selectedOption,
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
                          onPressed: () {
                            setState(() {
                              url = finalUrlList[index];
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AudioScreen(
                                    url: url,
                                  );
                                },
                              ),
                            );
                            print(finalUrlList[index]);
                          },
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
    );
  }
}
