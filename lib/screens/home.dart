import 'package:fitnet/models/nutrition_data.dart';
import 'package:fitnet/screens/meal_tracker.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/recipe.dart';
import 'package:fitnet/screens/recipe_search.dart';
// import 'package:fitnet/screens/tabs_screen.dart';
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

  Future<String> getUserInfo() async {
    // await FirebaseAuth.instance.currentUser().then((value) => print(value));
    if (await FirebaseAuth.instance.currentUser() != null) {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      _firestore.collection("users").document(firebaseUser.uid).snapshots();
      Future userName =
          _firestore.collection('users').document(firebaseUser.uid).get();
      return userName.then((value) async {
        final String name = await value.data['userName'].split(' ')[0];
        return name;
      });
    }
    return null;
  }

  // Future totalInfo() async {
  //   return [await getUserInfo(), await object.getRecipeInfo('6194281')];
  // }

  @override
  void initState() {
    super.initState();
    future = getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('EEEE ,d MMMM').format(now);

    return Consumer<NutritionData>(
      builder:
          (BuildContext context, NutritionData nutritionData, Widget child) {
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
                      // print(snapshot.data[1]);

                      // snapshot.data[1].forEach((element) {
                      //   print(element);
                      // });
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
                                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Color(0xFF171717),
                                ),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.start,
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
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        // SizedBox(
                                        //   width: SizeConfig.widthMultiplier,
                                        // ),
                                        // MyRadialProgess(
                                        //   width: SizeConfig.heightMultiplier * 22.5,
                                        //   height: SizeConfig.widthMultiplier * 25,
                                        //   progress: 0.7,
                                        // ),
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier,
                                        ),
                                        MyRadialProgess2(
                                          width:
                                              SizeConfig.heightMultiplier * 25,
                                          height:
                                              SizeConfig.heightMultiplier * 23,
                                          progress: 0.7,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.widthMultiplier * 0.5,
                                        ),

                                        MyIngredientProgress2(
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
                                          proteinProgress: 5,
                                          carbsProgress: 10,
                                          fatsProgress: 15,
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

                          // SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.pushNamed(context, MealTracker.id);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.fromLTRB(
                          //         SizeConfig.widthMultiplier * 3, 0, 0, 0),
                          //     height: SizeConfig.heightMultiplier * 27,
                          //     width: SizeConfig.widthMultiplier,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.all(Radius.circular(20)),
                          //       color: Color(0xFF171717),
                          //     ),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: <Widget>[
                          //         Align(
                          //           alignment: Alignment.topLeft,
                          //           child: Text(
                          //             formattedDate.toString(),
                          //             style: TextStyle(
                          //                 fontFamily: 'Roboto',
                          //                 fontSize: SizeConfig.textMultiplier * 2),
                          //           ),
                          //         ),
                          //         FutureBuilder<String>(
                          //           future: getUserInfo(),
                          //           builder: (BuildContext context,
                          //               AsyncSnapshot<String> snapshot) {
                          //             switch (snapshot.connectionState) {
                          //               case ConnectionState.waiting:
                          //                 return Text('');
                          //               default:
                          //                 if (snapshot.hasError)
                          //                   return new Text('');
                          //                 else
                          //                   return Align(
                          //                     alignment: Alignment.topLeft,
                          //                     child: new Text(
                          //                       'Hello,${snapshot.data}',
                          //                       style: TextStyle(
                          //                           fontFamily: 'Roboto',
                          //                           fontSize: SizeConfig.textMultiplier * 3,
                          //                           fontWeight: FontWeight.bold),
                          //                     ),
                          //                   );
                          //             }
                          //           },
                          //         ),
                          //         // MyRadialProgress(width:SizeConfig.heightMultiplier*0.2,height:SizeConfig.heightMultiplier*0.2)
                          //         Row(
                          //           children: <Widget>[
                          //             MyRadialProgess(
                          //               width: SizeConfig.heightMultiplier * 20,
                          //               height: SizeConfig.heightMultiplier * 20,
                          //               progress: 0.7,
                          //             ),
                          //           ],
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: SizeConfig.heightMultiplier * 3.5,
                          // ),
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
                                          // Navigator.pushNamed(context, RecipeSearch.id);
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
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                // Material(
                                                //     borderRadius: BorderRadius.all(
                                                //         Radius.circular(50)),
                                                //     // elevation: 4,
                                                //     child: Image.asset(
                                                //       'images/peachy_salad3.jpg',
                                                //       height: SizeConfig
                                                //               .heightMultiplier *
                                                //           35,
                                                //       width: SizeConfig
                                                //               .widthMultiplier *
                                                //           40,
                                                //     )),
                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //     image: DecorationImage(image:AssetImage('images/peachy_salad3.jpg'))
                                                //   ),
                                                // ),
                                                //   CircleAvatar(
                                                // // borderRadius: BorderRadius.all(
                                                // //     Radius.circular(50)),
                                                // // elevation: 4,
                                                // radius: 20,
                                                // child: Image.asset(
                                                //   'images/peachy_salad3.jpg',
                                                //   height: SizeConfig
                                                //           .heightMultiplier *
                                                //       45,
                                                //   width: SizeConfig
                                                //           .widthMultiplier *
                                                //       40,
                                                // )),
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    // elevation: 4,
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
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    // elevation: 4,
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
                                        // Container(
                                        //   margin: EdgeInsets.only(
                                        //       right: 10, bottom: 10),
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.all(
                                        //         Radius.circular(20)),
                                        //     // elevation: 4,
                                        //     child: Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: <Widget>[
                                        //         Image.asset(
                                        //           'images/Banana_Oatmeal_Cookies.jpg',
                                        //           height: SizeConfig
                                        //                   .heightMultiplier *
                                        //               30,
                                        //           width:
                                        //               SizeConfig.widthMultiplier *
                                        //                   45,
                                        //         ),
                                        //         Text(
                                        //           'Banana Oatmeal Cookies',
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
                                        // Container(
                                        //   margin: EdgeInsets.only(
                                        //       right: 10, bottom: 10),
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.all(
                                        //         Radius.circular(20)),
                                        //     // elevation: 4,
                                        //     child: Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: <Widget>[
                                        //         Image.asset(
                                        //             'images/broccoli_cheesy_bread.jpg')
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
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
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    // elevation: 4,
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
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    // elevation: 4,
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
                                  // Container(
                                  //   height: SizeConfig.heightMultiplier * 20,
                                  // ),
                                  // SingleChildScrollView(
                                  //     scrollDirection: Axis.horizontal,
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.start,
                                  //       children: <Widget>[
                                  //         Column(
                                  //           children: <Widget>[
                                  //             Image.asset(
                                  //               'images/butter_chicken.jpg',
                                  //               height: SizeConfig
                                  //                       .heightMultiplier *
                                  //                   30,
                                  //             )
                                  //           ],
                                  //         )
                                  //       ],
                                  //     )),
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
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                // Material(
                                                //     borderRadius: BorderRadius.all(
                                                //         Radius.circular(50)),
                                                //     // elevation: 4,
                                                //     child: Image.asset(
                                                //       'images/peachy_salad3.jpg',
                                                //       height: SizeConfig
                                                //               .heightMultiplier *
                                                //           35,
                                                //       width: SizeConfig
                                                //               .widthMultiplier *
                                                //           40,
                                                //     )),
                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //     image: DecorationImage(image:AssetImage('images/peachy_salad3.jpg'))
                                                //   ),
                                                // ),
                                                //   CircleAvatar(
                                                // // borderRadius: BorderRadius.all(
                                                // //     Radius.circular(50)),
                                                // // elevation: 4,
                                                // radius: 20,
                                                // child: Image.asset(
                                                //   'images/peachy_salad3.jpg',
                                                //   height: SizeConfig
                                                //           .heightMultiplier *
                                                //       45,
                                                //   width: SizeConfig
                                                //           .widthMultiplier *
                                                //       40,
                                                // )),
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    // elevation: 4,
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
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    // elevation: 4,
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
                                        // Container(
                                        //   margin: EdgeInsets.only(
                                        //       right: 10, bottom: 10),
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.all(
                                        //         Radius.circular(20)),
                                        //     // elevation: 4,
                                        //     child: Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: <Widget>[
                                        //         Image.asset(
                                        //           'images/Banana_Oatmeal_Cookies.jpg',
                                        //           height: SizeConfig
                                        //                   .heightMultiplier *
                                        //               30,
                                        //           width:
                                        //               SizeConfig.widthMultiplier *
                                        //                   45,
                                        //         ),
                                        //         Text(
                                        //           'Banana Oatmeal Cookies',
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
                                        // Container(
                                        //   margin: EdgeInsets.only(
                                        //       right: 10, bottom: 10),
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.all(
                                        //         Radius.circular(20)),
                                        //     // elevation: 4,
                                        //     child: Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: <Widget>[
                                        //         Image.asset(
                                        //             'images/broccoli_cheesy_bread.jpg')
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
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
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    // elevation: 4,
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
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    // elevation: 4,
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
                                        'Mental Health',
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
                                              return MentalHealthList();
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
                                  Container(
                                    height: SizeConfig.heightMultiplier * 20,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 3.5,
                                  ),
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

// Future<String> getUserInfo() async {
//   var firebaseUser = await FirebaseAuth.instance.currentUser();
//   _firestore.collection("users").document(firebaseUser.uid).snapshots();
//   Future userName = _firestore.collection('users').document(firebaseUser.uid).get();
//   return userName.then((value){
//     final String name=value.data['userName'];
//   });
// }

// Future<String> getUserInfo()async {
// var firebaseUser=await FirebaseAuth.instance.currentUser();
//    await  _firestore.collection("users").document(firebaseUser.uid).get().then((value){
//       setState(()  {
//       userName= value.data['userName'].split(' ')[0];
//       });
//   });
//   return userName;
// }

// class MyIngredientProgress extends StatelessWidget {
//   final String ingredient;
//   final double eatenAmount;
//   final double progress, width;
//   final Color progressColor;

//   const MyIngredientProgress(
//       {Key key,
//       this.ingredient,
//       this.eatenAmount,
//       this.progress,
//       this.progressColor,
//       this.width})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           ingredient,
//           style: TextStyle(
//               fontSize: SizeConfig.textMultiplier * 2, fontFamily: 'Roboto'),
//         ),
//         Row(
//           children: <Widget>[
//             Stack(children: <Widget>[
//               Container(
//                 height: SizeConfig.heightMultiplier,
//                 width: SizeConfig.widthMultiplier * 32.5,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(5),
//                   ),
//                   color: Color(0xFF595959),
//                 ),
//               ),
//               Container(
//                 height: SizeConfig.heightMultiplier,
//                 width: SizeConfig.widthMultiplier * progress,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(5),
//                   ),
//                   color: progressColor,
//                 ),
//               ),
//             ]),
//             SizedBox(
//               width: SizeConfig.widthMultiplier,
//             ),
//             Text(
//               '${eatenAmount}g',
//               style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }

// class MyRadialProgess extends StatelessWidget {
//   final double height, width, progress;
//   MyRadialProgess({this.height, this.width, this.progress});
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: MyRadialPainter(progress: progress),
//       child: Container(
//         height: height,
//         width: width,
//         child: Center(
//           child: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: '2000',
//                   style: TextStyle(
//                       fontFamily: 'Roboto',
//                       fontSize: SizeConfig.textMultiplier * 4,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(text: '\n'),
//                 TextSpan(
//                   text: 'cal',
//                   style: TextStyle(
//                       fontFamily: 'Roboto',
//                       fontSize: SizeConfig.textMultiplier * 3,
//                       fontWeight: FontWeight.w400),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyRadialPainter extends CustomPainter {
//   final double progress;

//   MyRadialPainter({this.progress});
//   @override
//   void paint(Canvas canvas, Size size) {
//     // TODO: implement paint
//     Paint paint = Paint()
//       ..strokeWidth = 10
//       ..color = Color(0xFF51D9FD)
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     Offset center = Offset(size.width / 2, size.height / 2);
//     // canvas.drawCircle(center, size.width / 2, paint);
//     double relativeProgress = 360 * progress;
//     canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2.1),
//         math.radians(-90), math.radians(-relativeProgress), false, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }

// class DietProgress extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class MyRadialProgess2 extends StatelessWidget {
  final double height, width, progress;
  MyRadialProgess2({this.height, this.width, this.progress});
  @override
  Widget build(BuildContext context) {
    return Consumer<NutritionData>(
      builder:
          (BuildContext context, NutritionData nutritionData, Widget child) {
        return CustomPaint(
          painter: MyRadialPainter2(progress: progress),
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

class MyRadialPainter2 extends CustomPainter {
  final double progress;

  MyRadialPainter2({this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Color(0xFF51D9FD)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    // canvas.drawCircle(center, size.width / 2, paint);
    double relativeProgress = 360 * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2.2),
        math.radians(-90), math.radians(-relativeProgress), false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // SizedBox(
            //   height: SizeConfig.heightMultiplier * 1.2,
            // ),
            Row(
              children: <Widget>[
                Text('Protein',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.2,
                        fontFamily: 'Roboto')),
              ],
            ),
            // SizedBox(
            //   height: SizeConfig.heightMultiplier * 5,
            // ),
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
            // SizedBox(
            //   height: SizeConfig.heightMultiplier * 5,
            // ),
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
