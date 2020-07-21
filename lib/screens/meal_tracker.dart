import 'package:fitnet/models/nutrition_data.dart';
import 'package:fitnet/models/user_data.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer2<NutritionData, UserData>(
      builder: (BuildContext context, nutritionData, UserData userData,
          Widget child) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                'Today',
                style: TextStyle(
                    fontFamily: 'CopperPlate',
                    fontSize: SizeConfig.textMultiplier * 3,
                    fontWeight: FontWeight.w400),
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
                      child: MyIngredientProgress(
                        proteinEatenAmount: nutritionData.finalProteinCount,
                        carbsEatenAmount: nutritionData.finalCarbsCount,
                        fatsEatenAmount: nutritionData.finalFatsCount,
                        proteinProgressColor: Color(0xFFEB1555),
                        carbsProgressColor: Color(0xFF03DAC5),
                        fatsProgressColor: Color(0xFFFACB2E),
                        // proteinProgress: (((1.5*2.205*userData.userWeight)-(nutritionData.finalProteinCount))/(1.5*2.205*userData.userWeight))*60,
                        proteinProgress: nutritionData.finalProteinCount == 0
                            ? 0
                            : nutritionData.finalProteinCount <=
                                    (userData.userWeight * 1.5 * 2.205)
                                ? (nutritionData.finalProteinCount /
                                        (userData.userWeight * 1.4 * 2.205)) *
                                    60
                                : 60,
                        // carbsProgress: 20,
                        carbsProgress: nutritionData.finalCarbsCount == 0
                            ? 0
                            : nutritionData.finalCarbsCount <=
                                    ((userData.finalUserMaintenanceCal -
                                            ((nutritionData.finalProteinCount *
                                                    4) +
                                                (nutritionData.finalFatsCount *
                                                    9))) /
                                        4)
                                ? ((nutritionData.finalCarbsCount /
                                        ((userData.finalUserMaintenanceCal -
                                                ((nutritionData
                                                            .finalProteinCount *
                                                        4) +
                                                    (nutritionData
                                                            .finalFatsCount *
                                                        9))) /
                                            4)) *
                                    60)
                                : 60,
                        // fatsProgress: 10,
                        fatsProgress: nutritionData.finalFatsCount == 0
                            ? 0
                            : nutritionData.finalFatsCount <=
                                    ((userData.finalUserMaintenanceCal *
                                            0.725) /
                                        9)
                                ? (nutritionData.finalFatsCount /
                                        ((userData.finalUserMaintenanceCal *
                                                0.725) /
                                            9)) *
                                    60
                                : 60,
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.heightMultiplier,
                      horizontal: SizeConfig.widthMultiplier * 3),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                                        nutritionData.finalNutritionData();
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
                                        nutritionData.finalNutritionData();
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
                                        nutritionData.removeLunchFood(index);
                                        nutritionData.finalNutritionData();
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
                                        nutritionData.finalNutritionData();
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
                                        nutritionData.removeDinnerFood(index);
                                        nutritionData.finalNutritionData();
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
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}

class MyIngredientProgress extends StatelessWidget {
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

  const MyIngredientProgress(
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
                        width: SizeConfig.widthMultiplier * 60,
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
                      proteinEatenAmount.toStringAsFixed(1) + 'g',
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
                        width: SizeConfig.widthMultiplier * 60,
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
                      carbsEatenAmount.toStringAsFixed(1) + 'g',
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
                        width: SizeConfig.widthMultiplier * 60,
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
                      fatsEatenAmount.toStringAsFixed(1) + 'g',
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
