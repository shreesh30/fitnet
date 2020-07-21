import 'package:fitnet/models/nutrition_data.dart';
import 'package:fitnet/models/user_data.dart';
import 'package:fitnet/screens/meal_tracker.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/recipe.dart';
import 'package:fitnet/screens/recipe_search.dart';
import 'package:fitnet/screens/workout_list.dart';
import 'package:fitnet/screens/workout_program.dart';
import 'package:fitnet/services/apiGetter.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String userName = "";
  Future future;
  RestClient object = RestClient();

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future getUserInfo() async {
    if (await FirebaseAuth.instance.currentUser() != null) {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      _firestore.collection("users").document(firebaseUser.uid).snapshots();
      Future userName =
          _firestore.collection('users').document(firebaseUser.uid).get();
      return userName.then((value) async {
        final String name = await value.data['userName'].split(' ')[0];
        final double finalMaintenanceCal = await value.data['maintenanceCal'];
        Provider.of<UserData>(context, listen: false).finalUserMaintenanceCal =
            finalMaintenanceCal;
        final double userWeight = await value.data['weight'];
        Provider.of<UserData>(context, listen: false).userWeight = userWeight;
        return name;
      });
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    future = getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('EEEE ,d MMMM').format(now);

    return Consumer2<NutritionData, UserData>(
      builder: (BuildContext context, NutritionData nutritionData,
          UserData userData, Widget child) {
        return Scaffold(
          body: SafeArea(
            child: FutureBuilder(
              future: future,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());

                  default:
                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.none)
                      return Center(child: new CircularProgressIndicator());
                    else
                      return ListView(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(40),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, CupertinoPageRoute(
                                  builder: (context) {
                                    return MealTracker();
                                  },
                                ));
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    SizeConfig.widthMultiplier * 4, 0, 0, 0),
                                height: SizeConfig.heightMultiplier * 38,
                                width: SizeConfig.widthMultiplier * 10,
                                decoration: BoxDecoration(
                                  color: Color(0xFF171717),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 2,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        formattedDate.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: snapshot.data != null
                                          ? Text(
                                              'Hello,${snapshot.data}',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      3,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Container(),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier,
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            MyRadialProgess(
                                              width:
                                                  SizeConfig.heightMultiplier *
                                                      25,
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      23,
                                              progress: 1.0,
                                              color: Color(0xFF595959),
                                            ),
                                            MyRadialProgess(
                                              width:
                                                  SizeConfig.heightMultiplier *
                                                      25,
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      23,
                                              progress: ((nutritionData
                                                      .finalCalorieCount /
                                                  userData
                                                      .finalUserMaintenanceCal)),
                                              color: Color(0xFF51D9FD),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.widthMultiplier * 0.5,
                                        ),
                                        MyIngredientProgress(
                                          proteinEatenAmount:
                                              nutritionData.finalProteinCount,
                                          carbsEatenAmount:
                                              nutritionData.finalCarbsCount,
                                          fatsEatenAmount:
                                              nutritionData.finalFatsCount,
                                          proteinProgressColor:
                                              Color(0xFFEB1555),
                                          carbsProgressColor: Color(0xFF03DAC5),
                                          fatsProgressColor: Color(0xFFFACB2E),
                                          proteinProgress: nutritionData
                                                      .finalProteinCount ==
                                                  0
                                              ? 0
                                              : nutritionData
                                                          .finalProteinCount <=
                                                      (userData.userWeight *
                                                          1.5 *
                                                          2.205)
                                                  ? (nutritionData
                                                              .finalProteinCount /
                                                          (userData.userWeight *
                                                              1.4 *
                                                              2.205)) *
                                                      25
                                                  : 25,
                                          carbsProgress:  nutritionData.finalCarbsCount == 0
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
                                    25)
                                : 25,
                                          fatsProgress: nutritionData
                                                      .finalFatsCount ==
                                                  0
                                              ? 0
                                              : nutritionData.finalFatsCount <=
                                                      ((userData.finalUserMaintenanceCal *
                                                              0.725) /
                                                          9)
                                                  ? (nutritionData
                                                              .finalFatsCount /
                                                          ((userData.finalUserMaintenanceCal *
                                                                  0.725) /
                                                              9)) *
                                                      25
                                                  : 25,
                                          // size: ,
                                        ),
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.widthMultiplier * 4.5,
                                  0,
                                  SizeConfig.widthMultiplier * 4.5,
                                  0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Recipes',
                                        style: TextStyle(
                                            fontFamily: 'CopperPlate',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              CupertinoPageRoute(
                                            builder: (context) {
                                              return RecipeSearch();
                                            },
                                          ));
                                        },
                                        child: Text(
                                          'Show More',
                                          style: TextStyle(
                                              color: Color(0xFF8B8A8D),
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.8),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                              builder: (context) {
                                                return Recipe(
                                                  recipeId: '6194281',
                                                  recipeName:
                                                      'Peachy Chicken Salad',
                                                );
                                              },
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              right: SizeConfig
                                                          .widthMultiplier <
                                                      8
                                                  ? SizeConfig.widthMultiplier *
                                                      2
                                                  : SizeConfig.widthMultiplier,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.asset(
                                                      'images/peachy_salad.jpg',
                                                      height: SizeConfig
                                                                  .widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .heightMultiplier *
                                                              30
                                                          : SizeConfig
                                                                  .heightMultiplier *
                                                              30,
                                                      width: SizeConfig.widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .widthMultiplier *
                                                              43
                                                          : SizeConfig
                                                                  .widthMultiplier *
                                                              30,
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Text(
                                                  'Peachy Chicken Salad',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                              builder: (context) {
                                                return Recipe(
                                                  recipeId: '12232853',
                                                  recipeName:
                                                      'Banana Oatmeal Cookies',
                                                );
                                              },
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              right: SizeConfig
                                                          .widthMultiplier <
                                                      8
                                                  ? SizeConfig.widthMultiplier *
                                                      2
                                                  : SizeConfig.widthMultiplier,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.asset(
                                                      'images/Banana_Oatmeal_Cookies.jpg',
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          30,
                                                      width: SizeConfig.widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .widthMultiplier *
                                                              45
                                                          : SizeConfig
                                                                  .widthMultiplier *
                                                              28,
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Text(
                                                  'Banana Oatmeal Cookies',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                              builder: (context) {
                                                return Recipe(
                                                  recipeId: '27587433',
                                                  recipeName:
                                                      'Broccoli Cheesy Bread',
                                                );
                                              },
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              right: SizeConfig
                                                          .widthMultiplier <
                                                      8
                                                  ? SizeConfig.widthMultiplier *
                                                      2
                                                  : SizeConfig.widthMultiplier,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.asset(
                                                      'images/broccoli_cheesy_bread.jpg',
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          30,
                                                      width: SizeConfig.widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .widthMultiplier *
                                                              41
                                                          : SizeConfig
                                                                  .widthMultiplier *
                                                              25,
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Text(
                                                  'Broccoli Cheesy Bread',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                              builder: (context) {
                                                return Recipe(
                                                  recipeId: '440385',
                                                  recipeName:
                                                      'Flourless Chocolate Cake',
                                                );
                                              },
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              right: SizeConfig
                                                          .widthMultiplier <
                                                      8
                                                  ? SizeConfig.widthMultiplier *
                                                      2
                                                  : SizeConfig.widthMultiplier,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.asset(
                                                      'images/flourless-chocolate-cake.jpg',
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          30,
                                                      width: SizeConfig.widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .widthMultiplier *
                                                              45
                                                          : SizeConfig
                                                                  .widthMultiplier *
                                                              27,
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Text(
                                                  'Flourless Chocolate Cake',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 3.5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Workout List',
                                        style: TextStyle(
                                            fontFamily: 'CopperPlate',
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              CupertinoPageRoute(
                                            builder: (context) {
                                              return WorkoutList();
                                            },
                                          ));
                                        },
                                        child: Text(
                                          'Show More',
                                          style: TextStyle(
                                              color: Color(0xFF8B8A8D),
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                              builder: (context) {
                                                return WorkoutProgram(
                                                  workoutProgramName:
                                                      'shred programs',
                                                );
                                              },
                                            ));
                                          },
                                          child: Container(
                                            // color: Colors.white,
                                            margin: EdgeInsets.only(
                                              right: SizeConfig
                                                          .widthMultiplier <
                                                      8
                                                  ? SizeConfig.widthMultiplier *
                                                      2
                                                  : SizeConfig.widthMultiplier,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.asset(
                                                      'images/jeremyBuendia.png',
                                                      height: SizeConfig
                                                                  .widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .heightMultiplier *
                                                              30
                                                          : SizeConfig
                                                                  .heightMultiplier *
                                                              30,
                                                      width: SizeConfig.widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .widthMultiplier *
                                                              43
                                                          : SizeConfig
                                                                  .widthMultiplier *
                                                              30,
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Text(
                                                  'Shred Programs',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                              builder: (context) {
                                                return WorkoutProgram(
                                                  workoutProgramName:
                                                      'Mass Building',
                                                );
                                              },
                                            ));
                                          },
                                          child: Container(
                                            // color: Colors.white,
                                            margin: EdgeInsets.only(
                                              right: SizeConfig
                                                          .widthMultiplier <
                                                      8
                                                  ? SizeConfig.widthMultiplier *
                                                      2
                                                  : SizeConfig.widthMultiplier,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.asset(
                                                      'images/flexWheeler.jpg',
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          30,
                                                      width: SizeConfig.widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .widthMultiplier *
                                                              45
                                                          : SizeConfig
                                                                  .widthMultiplier *
                                                              28,
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Text(
                                                  'Mass Building Programs',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                              builder: (context) {
                                                return Recipe(
                                                  recipeId: '27587433',
                                                  recipeName:
                                                      'Broccoli Cheesy Bread',
                                                );
                                              },
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              right: SizeConfig
                                                          .widthMultiplier <
                                                      8
                                                  ? SizeConfig.widthMultiplier *
                                                      2
                                                  : SizeConfig.widthMultiplier,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.asset(
                                                      'images/sergiConstance.jpg',
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          30,
                                                      width: SizeConfig.widthMultiplier <
                                                              8
                                                          ? SizeConfig
                                                                  .widthMultiplier *
                                                              41
                                                          : SizeConfig
                                                                  .widthMultiplier *
                                                              25,
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Text(
                                                  'Hypertrophy Program',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: SizeConfig
                                                              .heightMultiplier *
                                                          2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.push(context,
                                        //         CupertinoPageRoute(
                                        //       builder: (context) {
                                        //         return Recipe(
                                        //           recipeId: '440385',
                                        //           recipeName:
                                        //               'Flourless Chocolate Cake',
                                        //         );
                                        //       },
                                        //     ));
                                        //   },
                                        //   child: Container(
                                        //     margin: EdgeInsets.only(
                                        //       right: SizeConfig
                                        //                   .widthMultiplier <
                                        //               8
                                        //           ? SizeConfig.widthMultiplier *
                                        //               2
                                        //           : SizeConfig.widthMultiplier,
                                        //     ),
                                        //     child: Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       children: <Widget>[
                                        //         ClipRRect(
                                        //             borderRadius:
                                        //                 BorderRadius.all(
                                        //                     Radius.circular(
                                        //                         10)),
                                        //             child: Image.asset(
                                        //               'images/flourless-chocolate-cake.jpg',
                                        //               height: SizeConfig
                                        //                       .heightMultiplier *
                                        //                   30,
                                        //               width: SizeConfig.widthMultiplier <
                                        //                       8
                                        //                   ? SizeConfig
                                        //                           .widthMultiplier *
                                        //                       45
                                        //                   : SizeConfig
                                        //                           .widthMultiplier *
                                        //                       27,
                                        //             )),
                                        //         SizedBox(
                                        //           height: SizeConfig
                                        //               .heightMultiplier,
                                        //         ),
                                        //         Text(
                                        //           'Flourless Chocolate Cake',
                                        //           style: TextStyle(
                                        //               fontFamily: 'Roboto',
                                        //               fontSize: SizeConfig
                                        //                       .heightMultiplier *
                                        //                   2),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 3.5,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: <Widget>[
                                  //     Text(
                                  //       'Mental Health',
                                  //       style: TextStyle(
                                  //           fontFamily: 'CopperPlate',
                                  //           fontSize:
                                  //               SizeConfig.textMultiplier * 2.5,
                                  //           fontWeight: FontWeight.w400),
                                  //     ),
                                  //     GestureDetector(
                                  //       onTap: () {
                                  //         Navigator.push(context,
                                  //             CupertinoPageRoute(
                                  //           builder: (context) {
                                  //             return MentalHealthList();
                                  //           },
                                  //         ));
                                  //       },
                                  //       child: Text(
                                  //         'Show More',
                                  //         style: TextStyle(
                                  //             color: Color(0xFF8B8A8D),
                                  //             fontSize:
                                  //                 SizeConfig.textMultiplier *
                                  //                     1.8),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Container(
                                  //   height: SizeConfig.heightMultiplier * 20,
                                  // ),
                                  // SizedBox(
                                  //   height: SizeConfig.heightMultiplier * 3.5,
                                  // ),
                                ],
                              )),
                        ],
                      );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class MyRadialProgess extends StatelessWidget {
  final double height, width, progress;
  final Color color;
  MyRadialProgess({this.height, this.width, this.progress, this.color});
  @override
  Widget build(BuildContext context) {
    return Consumer<NutritionData>(
      builder:
          (BuildContext context, NutritionData nutritionData, Widget child) {
        return CustomPaint(
          painter: MyRadialPainter(progress: progress, color: color),
          child: Container(
            // color: Colors.white,
            margin: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier,
                horizontal: SizeConfig.widthMultiplier * 1.5),
            height: height,
            width: width,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: nutritionData.finalCalorieCount.toStringAsFixed(0),
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: SizeConfig.textMultiplier * 4,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: 'cal',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: SizeConfig.textMultiplier * 3,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyRadialPainter extends CustomPainter {
  final double progress;
  final Color color;

  MyRadialPainter({this.progress, this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    double relativeProgress = 360 * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2.2),
        math.radians(-90), math.radians(relativeProgress), false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Protein',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.2,
                        fontFamily: 'Roboto')),
              ],
            ),
            Row(
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    height: SizeConfig.heightMultiplier * 1.2,
                    width: SizeConfig.widthMultiplier > 5
                        ? SizeConfig.widthMultiplier * 42
                        : SizeConfig.widthMultiplier * 25,
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
                  proteinEatenAmount.toStringAsFixed(0) + 'g',
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            Text('Carbs',
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2.2,
                    fontFamily: 'Roboto')),
            Row(
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    height: SizeConfig.heightMultiplier * 1.2,
                    width: SizeConfig.widthMultiplier > 5
                        ? SizeConfig.widthMultiplier * 42
                        : SizeConfig.widthMultiplier * 25,
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
                  carbsEatenAmount.toStringAsFixed(0) + 'g',
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            Text('Fats',
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2.2,
                    fontFamily: 'Roboto')),
            Row(
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    height: SizeConfig.heightMultiplier * 1.2,
                    width: SizeConfig.widthMultiplier > 5
                        ? SizeConfig.widthMultiplier * 42
                        : SizeConfig.widthMultiplier * 25,
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
                  fatsEatenAmount.toStringAsFixed(0) + 'g',
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
