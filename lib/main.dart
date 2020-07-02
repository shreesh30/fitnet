import 'package:fitnet/home/tab_screen_home_page.dart';
import 'package:fitnet/models/auth_status_data.dart';
import 'package:fitnet/models/nutrition_data.dart';
import 'package:fitnet/screens/audio_screen.dart';
import 'package:fitnet/screens/days_list.dart';
import 'package:fitnet/screens/meal_tracker.dart';
import 'package:fitnet/screens/meal_tracker_food.dart';
import 'package:fitnet/screens/meal_tracker_food_search.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/mental_health_selected_option.dart';
import 'package:fitnet/screens/new_user.dart';
import 'package:fitnet/screens/recipe.dart';
import 'package:fitnet/screens/recipe_search.dart';
import 'package:fitnet/screens/root_page.dart';
import 'package:fitnet/screens/splash_screen.dart';
import 'package:fitnet/screens/user_profile.dart';
import 'package:fitnet/screens/video_screen.dart';
import 'package:fitnet/screens/weeks_list.dart';
import 'package:fitnet/screens/workout.dart';
import 'package:fitnet/screens/workout_list.dart';
import 'package:fitnet/screens/workout_program.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/screens/landing_page.dart';
import 'package:fitnet/screens/login_screen.dart';
import 'package:fitnet/screens/home.dart';
import 'package:flutter/services.dart';
import 'package:fitnet/screens/registration_screen.dart';
// import 'package:fitnet/screens/tabs_screen.dart';
// import 'package:fitnet/home/tab_screen_home_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatefulWidget {
//   static bool isLoggedin=false;
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // bool isLoggedIn = false;
//   // final  _auth=FirebaseAuth.instance.currentUser();
//   // // final uid= _auth.uid;
//   // Future<bool> home() async {
//   //   if (await _auth== null) {
//   //     return false;
//   //   } else
//   //     return true;
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //    Future future = home();
//   //   future.then((isLoggedIn) {
//   //     if (isLoggedIn == false) {
//   //       setState(() {
//   //         isLoggedIn = false;
//   //       });
//   //     } else
//   //       setState(() {
//   //         isLoggedIn = true;
//   //       });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         SizeConfig().init(constraints);
//         return MaterialApp(
//           theme: ThemeData.dark().copyWith(
//             scaffoldBackgroundColor: Color(0xff0f0f0f),
//           ),
//           // initialRoute:FirebaseAuth.instance.currentUser().then((value) => null)!=null?TabScreenHomePage.id:LandingPage.id,
//           // initialRoute: LandingPage.id,
//           // home: FutureBuilder(
//           //   future: home(),
//           //   builder: (context, snapshot) {
//           //     if (snapshot.data == false) {
//           //       return LandingPage();
//           //     } else
//           //       return TabsScreen();
//           //   },
//           // ),

//           // home: MyApp.isLoggedin==false?LandingPage():TabsScreen(),
//           home: RootPage(),

//           routes: {
//             SplashScreen.id: (context) => SplashScreen(),
//             LandingPage.id: (context) => LandingPage(),
//             LoginPage.id: (context) => LoginPage(),
//             HomePage.id: (context) => HomePage(),
//             RegistrationPage.id: (context) => RegistrationPage(),
//             NewUser.id: (context) => NewUser(),
//             WorkoutList.id: (context) => WorkoutList(),
//             WorkoutProgram.id: (context) => WorkoutProgram(),
//             WeeksList.id: (context) => WeeksList(),
//             DaysList.id: (context) => DaysList(),
//             Workout.id: (context) => Workout(),
//             VideoScreen.id: (context) => VideoScreen(),
//             MentalHealthList.id: (context) => MentalHealthList(),
//             MentalHealthSelectedOption.id: (context) =>
//                 MentalHealthSelectedOption(),
//             AudioScreen.id: (context) => AudioScreen(),
//             RecipeSearch.id: (context) => RecipeSearch(),
//             Recipe.id: (context) => Recipe(),
//             MealTracker.id: (context) => MealTracker(),
//             UserProfile.id: (context) => UserProfile(),
//             TabsScreen.id: (context) => TabsScreen(),
//             TabScreenHomePage.id: (context) => TabScreenHomePage(),
//             RootPage.id:(context)=>RootPage()
//           },
//         );
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MultiProvider(
          // create: (BuildContext context) => AuthStatusData(),
          providers: [
            ChangeNotifierProvider<AuthStatusData>(
              create: (context) => AuthStatusData(),
            ),
            ChangeNotifierProvider<NutritionData>(
              create: (context) => NutritionData(),
            )
          ],
          child: MaterialApp(
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Color(0xff0f0f0f),
            ),
            // initialRoute:FirebaseAuth.instance.currentUser().then((value) => null)!=null?TabScreenHomePage.id:LandingPage.id,
            // initialRoute: LandingPage.id,
            // home: FutureBuilder(
            //   future: home(),
            //   builder: (context, snapshot) {
            //     if (snapshot.data == false) {
            //       return LandingPage();
            //     } else
            //       return TabsScreen();
            //   },
            // ),

            // home: MyApp.isLoggedin==false?LandingPage():TabsScreen(),
            home: RootPage(),

            routes: {
              SplashScreen.id: (context) => SplashScreen(),
              LandingPage.id: (context) => LandingPage(),
              LoginPage.id: (context) => LoginPage(),
              HomePage.id: (context) => HomePage(),
              RegistrationPage.id: (context) => RegistrationPage(),
              NewUser.id: (context) => NewUser(),
              WorkoutList.id: (context) => WorkoutList(),
              WorkoutProgram.id: (context) => WorkoutProgram(),
              WeeksList.id: (context) => WeeksList(),
              DaysList.id: (context) => DaysList(),
              Workout.id: (context) => Workout(),
              VideoScreen.id: (context) => VideoScreen(),
              MentalHealthList.id: (context) => MentalHealthList(),
              MentalHealthSelectedOption.id: (context) =>
                  MentalHealthSelectedOption(),
              AudioScreen.id: (context) => AudioScreen(),
              RecipeSearch.id: (context) => RecipeSearch(),
              Recipe.id: (context) => Recipe(),
              MealTracker.id: (context) => MealTracker(),
              UserProfile.id: (context) => UserProfile(),
              // TabsScreen.id: (context) => TabsScreen(),
              TabScreenHomePage.id: (context) => TabScreenHomePage(),
              RootPage.id: (context) => RootPage(),
              MealTrackerRecipeSearch.id: (context) =>
                  MealTrackerRecipeSearch(),
              MealTrackerFood.id: (context) => MealTrackerFood()
            },
          ),
        );
      },
    );
  }
}
