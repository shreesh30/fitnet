import 'package:fitnet/services/apiGetter.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class MealTrackerFood extends StatefulWidget {
  static const String id='meal_tracker_food';

  final String foodName;
  final String foodId;

  const MealTrackerFood({Key key, this.foodName, this.foodId}) : super(key: key);
  @override
  _MealTrackerFoodState createState() => _MealTrackerFoodState();
}

class _MealTrackerFoodState extends State<MealTrackerFood> {
  RestClient object=RestClient();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    object.getFood(widget.foodId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        automaticallyImplyLeading: false,
          leading: IconButton(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
            icon: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.heightMultiplier * 3,
              color: Color(0xFFFD5739),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        // centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.foodName,
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
    );
  }
}