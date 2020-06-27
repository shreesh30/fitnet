import 'package:fitnet/screens/meal_tracker_recipe_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class MealTracker extends StatefulWidget {
  static const String id = 'meal_tracker';
  @override
  _MealTrackerState createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  @override
  Widget build(BuildContext context) {
    // return CommonScaffold(
    //   appbar: true,
    //   automaticallyImplyLeading: false,
    //   text: 'Today',

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
          title: Text(
            'Today',
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF0F0F0F),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.widthMultiplier * 2,
                  SizeConfig.heightMultiplier * 2,
                  SizeConfig.widthMultiplier * 2,
                  SizeConfig.heightMultiplier * 2),
              child: Container(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.widthMultiplier,
                      SizeConfig.heightMultiplier * 2,
                      SizeConfig.widthMultiplier,
                      SizeConfig.heightMultiplier * 2),
                  height: SizeConfig.heightMultiplier * 30,
                  width: SizeConfig.widthMultiplier * 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFF171717),
                  ),
                  child: MyIngredientProgress2(
                    proteinEatenAmount: 20,
                    carbsEatenAmount: 20,
                    fatsEatenAmount: 20,
                    proteinProgressColor: Color(0xFFEB1555),
                    carbsProgressColor: Color(0xFF03DAC5),
                    fatsProgressColor: Color(0xFFFACB2E),
                    proteinProgress: 30,
                    carbsProgress: 20,
                    fatsProgress: 10,
                    // size: ,
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier,
                  horizontal: SizeConfig.widthMultiplier * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ListTile(),
                  Card(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 2,
                        horizontal: SizeConfig.widthMultiplier * 2),
                    color: Color(0xff0f0f0f),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Breakfast',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2.5,
                                  fontWeight: FontWeight.w300),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          MealTrackerRecipeSearch(),
                                    ));
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFFFD5739),
                                size: SizeConfig.heightMultiplier * 3,
                              ),
                            )
                          ],
                        ),
                        Column()
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    // indent: SizeConfig.widthMultiplier,
                    // endIndent: SizeConfig.widthMultiplier * 3,
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 2,
                        horizontal: SizeConfig.widthMultiplier * 2),
                    color: Color(0xff0f0f0f),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Morning Snack',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2.5,
                                  fontWeight: FontWeight.w300),
                            ),
                            IconButton(
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          MealTrackerRecipeSearch(),
                                    ));
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFFFD5739),
                                size: SizeConfig.heightMultiplier * 3,
                              ),
                            )
                          ],
                        ),
                        Column()
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    // indent: SizeConfig.widthMultiplier,
                    // endIndent: SizeConfig.widthMultiplier * 3,
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 2,
                        horizontal: SizeConfig.widthMultiplier * 2),
                    color: Color(0xff0f0f0f),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Lunch',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2.5,
                                  fontWeight: FontWeight.w300),
                            ),
                            IconButton(
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          MealTrackerRecipeSearch(),
                                    ));
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFFFD5739),
                                size: SizeConfig.heightMultiplier * 3,
                              ),
                            )
                          ],
                        ),
                        Column()
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    // indent: SizeConfig.widthMultiplier,
                    // endIndent: SizeConfig.widthMultiplier * 3,
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 2,
                        horizontal: SizeConfig.widthMultiplier * 2),
                    color: Color(0xff0f0f0f),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Evening Snack',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2.5,
                                  fontWeight: FontWeight.w300),
                            ),
                            IconButton(
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          MealTrackerRecipeSearch(),
                                    ));
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFFFD5739),
                                size: SizeConfig.heightMultiplier * 3,
                              ),
                            ),
                          ],
                        ),
                        Column()
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    // indent: SizeConfig.widthMultiplier,
                    // endIndent: SizeConfig.widthMultiplier * 3,
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 2,
                        horizontal: SizeConfig.widthMultiplier * 2),
                    color: Color(0xff0f0f0f),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Dinner',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2.5,
                                  fontWeight: FontWeight.w300),
                            ),
                            IconButton(
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          MealTrackerRecipeSearch(),
                                    ));
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFFFD5739),
                                size: SizeConfig.heightMultiplier * 3,
                              ),
                            )
                          ],
                        ),
                        Column()
                      ],
                    ),
                  ),
                  // Divider(color: Colors.white,indent: SizeConfig.widthMultiplier,endIndent: SizeConfig.widthMultiplier*3,)
                ],
              ),
            ),
          ],
        ));
  }
}

// class MyIngredientProgress extends StatelessWidget {
//   final String ingredient;
//   final double eatenAmount;
//   final double progress, width;
//   final Color progressColor;
//   final double size;

//   const MyIngredientProgress(
//       {Key key,
//       this.ingredient,
//       this.eatenAmount,
//       this.progress,
//       this.progressColor,
//       this.width,
//       this.size})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         Container(
//             child: Text(
//           ingredient,
//           style: TextStyle(
//               fontSize: SizeConfig.textMultiplier * 2.2, fontFamily: 'Roboto'),
//         )),
//         // SizedBox(
//         //   width: size,
//         // ),
//         Container(
//           child: Row(
//             // mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Stack(children: <Widget>[
//                 Container(
//                   height: SizeConfig.heightMultiplier * 1.2,
//                   width: SizeConfig.widthMultiplier * 65,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(5),
//                     ),
//                     color: Color(0xFF595959),
//                   ),
//                 ),
//                 Container(
//                   height: SizeConfig.heightMultiplier * 1.2,
//                   width: SizeConfig.widthMultiplier * progress,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(5),
//                     ),
//                     color: progressColor,
//                   ),
//                 ),
//               ]),
//               // SizedBox(
//               //   width: SizeConfig.widthMultiplier,
//               // ),
//               Text('${eatenAmount}g')
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

class MyIngredientProgress2 extends StatelessWidget {
  final String ingredient;
  final double width;
  final double size;
  final double proteinProgress;
  final double carbsProgress;
  final double fatsProgress;
  final double proteinEatenAmount;
  final double carbsEatenAmount;
  final double fatsEatenAmount;
  final Color proteinProgressColor;
  final Color carbsProgressColor;
  final Color fatsProgressColor;

  const MyIngredientProgress2(
      {Key key,
      this.ingredient,
      this.width,
      this.size,
      this.proteinProgress,
      this.carbsProgress,
      this.fatsProgress,
      this.proteinEatenAmount,
      this.carbsEatenAmount,
      this.fatsEatenAmount,
      this.proteinProgressColor,
      this.carbsProgressColor,
      this.fatsProgressColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3.5,
                ),
                Text('Protein',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.2,
                        fontFamily: 'Roboto')),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 6,
                ),
                Text('Carbs',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.2,
                        fontFamily: 'Roboto')),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 6,
                ),
                Text('Fats',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.2,
                        fontFamily: 'Roboto')),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3.5,
                ),
                Row(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        height: SizeConfig.heightMultiplier * 1.2,
                        width: SizeConfig.widthMultiplier * 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Color(0xFF595959),
                        ),
                      ),
                      Container(
                        height: SizeConfig.heightMultiplier * 1.2,
                        width: SizeConfig.widthMultiplier * proteinProgress,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: proteinProgressColor,
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: SizeConfig.widthMultiplier,
                    ),
                    Text(
                      '${proteinEatenAmount}g',
                      style:
                          TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 7,
                ),
                Row(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        height: SizeConfig.heightMultiplier * 1.2,
                        width: SizeConfig.widthMultiplier * 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Color(0xFF595959),
                        ),
                      ),
                      Container(
                        height: SizeConfig.heightMultiplier * 1.2,
                        width: SizeConfig.widthMultiplier * carbsProgress,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: carbsProgressColor,
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: SizeConfig.widthMultiplier,
                    ),
                    Text(
                      '${carbsEatenAmount}g',
                      style:
                          TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 7,
                ),
                Row(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        height: SizeConfig.heightMultiplier * 1.2,
                        width: SizeConfig.widthMultiplier * 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Color(0xFF595959),
                        ),
                      ),
                      Container(
                        height: SizeConfig.heightMultiplier * 1.2,
                        width: SizeConfig.widthMultiplier * fatsProgress,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: fatsProgressColor,
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: SizeConfig.widthMultiplier,
                    ),
                    Text(
                      '${fatsEatenAmount}g',
                      style:
                          TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
                    )
                  ],
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
