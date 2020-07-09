import 'package:fitnet/models/nutrition_data.dart';
import 'package:fitnet/screens/meal_tracker_food_search.dart';
import 'package:fitnet/services/apiGetter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class MealTracker extends StatefulWidget {
  static const String id = 'meal_tracker';
  @override
  _MealTrackerState createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  RestClient object = RestClient();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //     Provider.of<NutritionData>(context).finalFoodsLists();
    
  // }
  @override
  Widget build(BuildContext context) {
    // Provider.of<NutritionData>(context).finalFoodsLists();
    return Consumer<NutritionData>(
      builder: (BuildContext context, nutritionData, Widget child) {
        // nutritionData.finalFoodsLists();
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
              // controller: ScrollControlle,
              // physics: NeverScrollableScrollPhysics(),
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
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1.5,
                            left: SizeConfig.widthMultiplier * 2,
                            right: SizeConfig.widthMultiplier * 2,
                            bottom: Provider.of<NutritionData>(context)
                                        .breakfastFoodName
                                        .length ==
                                    0
                                ? SizeConfig.heightMultiplier * 1.5
                                : 0),
                        title: Text(
                          'Breakfast',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: SizeConfig.textMultiplier * 2.5,
                              fontWeight: FontWeight.w300),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Color(0xFFFD5739),
                            size: SizeConfig.heightMultiplier * 3,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      MealTrackerRecipeSearch(),
                                ));
                            nutritionData.mealName = 'breakfast';
                          },
                        ),
                      ),
                      nutritionData.breakfastFoodName.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: nutritionData.breakfastFoodName.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 2,
                                      right: SizeConfig.widthMultiplier * 2,
                                      top: SizeConfig.widthMultiplier > 8
                                          ? SizeConfig.heightMultiplier
                                          : 0),
                                  title: Text(
                                    nutritionData.breakfastFoodName[index],
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  // trailing: IconButton(
                                  // icon: Icon(
                                  //   Icons.more_vert,
                                  //   color: Color(0xFFFD5739),
                                  //   size: SizeConfig.heightMultiplier * 2.5,
                                  // ),
                                  //   onPressed: () {
                                  //     return PopupMenuButton(itemBuilder: (context) {
                                  //       return [
                                  //         PopupMenuItem(child: Text('data'))
                                  //       ];
                                  //     },);
                                  //   },
                                  // ),
                                  trailing: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Color(0xFFFD5739),
                                      size: SizeConfig.heightMultiplier * 2.5,
                                    ),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        nutritionData
                                            .removeBreakfastFood(index);
                                        // print(nutritionData.breakfastFoodName);
                                        // print(nutritionData.breakfastFoodCalories);
                                        // print(nutritionData.breakfastFoodCarbs);
                                        // print(nutritionData.breakfastFoodFats);
                                        // print(nutritionData.breakfastFoodProtein);
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text('Remove'),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                );
                              },
                            )
                          : Container(),
                      // Card(
                      //   margin: EdgeInsets.symmetric(
                      //       vertical: SizeConfig.heightMultiplier * 2,
                      //       horizontal: SizeConfig.widthMultiplier * 2),
                      //   color: Color(0xff0f0f0f),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: <Widget>[
                      //           Text(
                      //             'Breakfast',
                      // style: TextStyle(
                      //     fontFamily: 'Roboto',
                      //     fontSize: SizeConfig.textMultiplier * 2.5,
                      //     fontWeight: FontWeight.w300),
                      //           ),
                      //           IconButton(
                      //             onPressed: () {
                      //               // object.getFoodInfo('butter coffee');
                      //               // showSearch(
                      //               //     context: context, delegate: DataSearch());
                      //               Navigator.push(
                      //                   context,
                      //                   CupertinoPageRoute(
                      //                     builder: (context) =>
                      //                         MealTrackerRecipeSearch(),
                      //                   ));
                      //             },
                      //             icon: Icon(
                      //               Icons.add_circle_outline,
                      // color: Color(0xFFFD5739),
                      // size: SizeConfig.heightMultiplier * 3,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       //  Provider.of<NutritionData>(context,listen: false).foodName.length>0?
                      //       // ListView.builder(itemCount: Provider.of<NutritionData>(context,listen: false).foodName.length,itemBuilder: (context, index) {
                      //       //   return Card(
                      //       //     child: Row(
                      //       //       children: <Widget>[
                      //       //         Text( Provider.of<NutritionData>(context,listen: false).foodName[index])
                      //       //       ],
                      //       //     ),
                      //       //   );
                      //       // },):Container()
                      //       // ListTile(subtitle: Row(children: <Widget>[Text('inside')],),)
                      //     ],
                      //   ),
                      // ),
                      Divider(
                        color: Colors.white,
                        // indent: SizeConfig.widthMultiplier,
                        // endIndent: SizeConfig.widthMultiplier * 3,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1.5,
                            left: SizeConfig.widthMultiplier * 2,
                            right: SizeConfig.widthMultiplier * 2,
                            bottom:
                                nutritionData.morningSnackFoodName.length == 0
                                    ? SizeConfig.heightMultiplier * 1.5
                                    : 0),
                        title: Text(
                          'Morning Snack',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: SizeConfig.textMultiplier * 2.5,
                              fontWeight: FontWeight.w300),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Color(0xFFFD5739),
                            size: SizeConfig.heightMultiplier * 3,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      MealTrackerRecipeSearch(),
                                ));
                            nutritionData.mealName = 'morning_snack';
                          },
                        ),
                      ),
                      nutritionData.morningSnackFoodName.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  nutritionData.morningSnackFoodName.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 2,
                                      right: SizeConfig.widthMultiplier * 2,
                                      top: SizeConfig.widthMultiplier > 8
                                          ? SizeConfig.heightMultiplier
                                          : 0),
                                  title: Text(
                                    nutritionData.morningSnackFoodName[index],
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontWeight: FontWeight.w300),
                                  ),
                                        trailing: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Color(0xFFFD5739),
                                      size: SizeConfig.heightMultiplier * 2.5,
                                    ),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        nutritionData
                                            .removeMorningSnackFood(index);
                                        // print(nutritionData.breakfastFoodName);
                                        // print(nutritionData.breakfastFoodCalories);
                                        // print(nutritionData.breakfastFoodCarbs);
                                        // print(nutritionData.breakfastFoodFats);
                                        // print(nutritionData.breakfastFoodProtein);
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text('Remove'),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                );
                              },
                            )
                          : Container(),
                      Divider(
                        color: Colors.white,
                        // indent: SizeConfig.widthMultiplier,
                        // endIndent: SizeConfig.widthMultiplier * 3,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1.5,
                            left: SizeConfig.widthMultiplier * 2,
                            right: SizeConfig.widthMultiplier * 2,
                            bottom: nutritionData.lunchFoodName.length == 0
                                ? SizeConfig.heightMultiplier * 1.5
                                : 0),
                        title: Text(
                          'Lunch',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: SizeConfig.textMultiplier * 2.5,
                              fontWeight: FontWeight.w300),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Color(0xFFFD5739),
                            size: SizeConfig.heightMultiplier * 3,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      MealTrackerRecipeSearch(),
                                ));
                            nutritionData.mealName = 'lunch';
                          },
                        ),
                      ),
                      nutritionData.lunchFoodName.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: nutritionData.lunchFoodName.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 2,
                                      right: SizeConfig.widthMultiplier * 2,
                                      top: SizeConfig.widthMultiplier > 8
                                          ? SizeConfig.heightMultiplier
                                          : 0),
                                  title: Text(
                                    nutritionData.lunchFoodName[index],
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontWeight: FontWeight.w300),
                                  ),
                                         trailing: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Color(0xFFFD5739),
                                      size: SizeConfig.heightMultiplier * 2.5,
                                    ),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        nutritionData
                                            .removeLunchFood(index);
                                        // print(nutritionData.breakfastFoodName);
                                        // print(nutritionData.breakfastFoodCalories);
                                        // print(nutritionData.breakfastFoodCarbs);
                                        // print(nutritionData.breakfastFoodFats);
                                        // print(nutritionData.breakfastFoodProtein);
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text('Remove'),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                );
                              },
                            )
                          : Container(),
                      Divider(
                        color: Colors.white,
                        // indent: SizeConfig.widthMultiplier,
                        // endIndent: SizeConfig.widthMultiplier * 3,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1.5,
                            left: SizeConfig.widthMultiplier * 2,
                            right: SizeConfig.widthMultiplier * 2,
                            bottom:
                                nutritionData.eveningSnackFoodName.length == 0
                                    ? SizeConfig.heightMultiplier * 1.5
                                    : 0),
                        title: Text(
                          'Evening Snack',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: SizeConfig.textMultiplier * 2.5,
                              fontWeight: FontWeight.w300),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Color(0xFFFD5739),
                            size: SizeConfig.heightMultiplier * 3,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      MealTrackerRecipeSearch(),
                                ));
                            nutritionData.mealName = 'evening_snack';
                          },
                        ),
                      ),
                      nutritionData.eveningSnackFoodName.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  nutritionData.eveningSnackFoodName.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 2,
                                      right: SizeConfig.widthMultiplier * 2,
                                      top: SizeConfig.widthMultiplier > 8
                                          ? SizeConfig.heightMultiplier
                                          : 0),
                                  title: Text(
                                    nutritionData.eveningSnackFoodName[index],
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontWeight: FontWeight.w300),
                                  ),
                                        trailing: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Color(0xFFFD5739),
                                      size: SizeConfig.heightMultiplier * 2.5,
                                    ),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        nutritionData
                                            .removeEveningSnackFood(index);
                                        print(nutritionData.eveningSnackFoodName);
                                        print(nutritionData.eveningSnackFoodCalories);
                                        print(nutritionData.eveningSnackFoodCarbs);
                                        print(nutritionData.eveningSnackFoodFats);
                                        print(nutritionData.eveningSnackFoodFats);
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text('Remove'),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                );
                              },
                            )
                          : Container(),
                      Divider(
                        color: Colors.white,
                        // indent: SizeConfig.widthMultiplier,
                        // endIndent: SizeConfig.widthMultiplier * 3,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1.5,
                            left: SizeConfig.widthMultiplier * 2,
                            right: SizeConfig.widthMultiplier * 2,
                            bottom: Provider.of<NutritionData>(context)
                                        .dinnerFoodName
                                        .length ==
                                    0
                                ? SizeConfig.heightMultiplier * 1.5
                                : 0),
                        title: Text(
                          'Dinner',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: SizeConfig.textMultiplier * 2.5,
                              fontWeight: FontWeight.w300),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Color(0xFFFD5739),
                            size: SizeConfig.heightMultiplier * 3,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      MealTrackerRecipeSearch(),
                                ));
                            nutritionData.mealName = 'dinner';
                          },
                        ),
                      ),
                      nutritionData.dinnerFoodName.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: nutritionData.dinnerFoodName.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 2,
                                      right: SizeConfig.widthMultiplier * 2,
                                      top: SizeConfig.widthMultiplier > 8
                                          ? SizeConfig.heightMultiplier
                                          : 0),
                                  title: Text(
                                    nutritionData.dinnerFoodName[index],
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontWeight: FontWeight.w300),
                                  ),
                                         trailing: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Color(0xFFFD5739),
                                      size: SizeConfig.heightMultiplier * 2.5,
                                    ),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        nutritionData
                                            .removeDinnerFood(index);
                                        // print(nutritionData.breakfastFoodName);
                                        // print(nutritionData.breakfastFoodCalories);
                                        // print(nutritionData.breakfastFoodCarbs);
                                        // print(nutritionData.breakfastFoodFats);
                                        // print(nutritionData.breakfastFoodProtein);
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text('Remove'),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                );
                              },
                            )
                          : Container(),
                      // Divider(color: Colors.white,indent: SizeConfig.widthMultiplier,endIndent: SizeConfig.widthMultiplier*3,)
                    ],
                  ),
                ),
              ],
            ));
      },
    );
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

