import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:fitnet/screens/mental_health_selected_option.dart';


class MentalHealthListItems extends StatelessWidget {
  const MentalHealthListItems({
    Key key,
    @required Future future,
  }) : _future = future, super(key: key);

  final Future _future;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: SizeConfig.widthMultiplier * 4),
                              child: Divider(color: Color(0xff8B8A8D)),
                            ),
                        itemCount: snapshot.data != null
                            ? snapshot.data.length
                            : 0,
                        itemBuilder: (context, index) {
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
                                  return MentalHealthSelectedOption(
                                    selectedOption:
                                        snapshot.data[index],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[index]
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      3),
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
                        }),
                  );
            }
          }),
    );
  }
}
