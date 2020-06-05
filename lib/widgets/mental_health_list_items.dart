import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:fitnet/screens/mental_health_selected_option.dart';


class MentalHealthListItems extends StatelessWidget {
 MentalHealthListItems({this.finalMentalHealthList});

  final List finalMentalHealthList;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
        child: ListView.separated(
            separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: SizeConfig.widthMultiplier * 4),
                  child: Divider(color: Color(0xff8B8A8D)),
                ),
            itemCount: finalMentalHealthList != null ? finalMentalHealthList.length : 0,
            itemBuilder: (context, index) {
              if (finalMentalHealthList != null) {
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
                        return MentalHealthSelectedOption(selectedOption: finalMentalHealthList[index],);
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
                                finalMentalHealthList[index].toString(),
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