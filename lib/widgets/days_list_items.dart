import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:fitnet/screens/days_list.dart';
import 'package:fitnet/screens/workout.dart';

class DaysListItems extends StatelessWidget {
  DaysListItems({this.finalDaysList,this.widget});

  final List finalDaysList;
  final DaysList widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
      child: ListView.separated(
          separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: SizeConfig.widthMultiplier * 4),
                child: Divider(color: Color(0xff8B8A8D)),
              ),
          itemCount: finalDaysList != null ? finalDaysList.length : 0,
          itemBuilder: (context, index) {
            if (finalDaysList != null) {
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
                      return Workout(
                        dayNumber: finalDaysList[index].toString(),
                        weekNumber: widget.weekNumber,
                        workoutName: widget.workoutName,
                        workoutProgramName: widget.workoutProgramName,
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
                              finalDaysList[index].toString(),
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
    );
  }
}
