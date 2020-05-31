import 'package:fitnet/screens/days_list.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/mental_health_selected_option.dart';
import 'package:fitnet/screens/new_user.dart';
import 'package:fitnet/screens/splash_screen.dart';
import 'package:fitnet/screens/video_screen.dart';
import 'package:fitnet/screens/weeks_list.dart';
import 'package:fitnet/screens/workout.dart';
import 'package:fitnet/screens/workout_list.dart';
import 'package:fitnet/screens/workout_program.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/screens/landing_page.dart';
import 'package:fitnet/screens/login_screen.dart';
import 'package:fitnet/screens/home.dart';
import 'package:flutter/services.dart';
import 'package:fitnet/screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MaterialApp(
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Color(0xff0f0f0f),
          ),
          initialRoute:LandingPage.id,
          routes: {
            SplashScreen.id: (context) => SplashScreen(),
            LandingPage.id: (context) => LandingPage(),
            LoginPage.id: (context) => LoginPage(),
            HomePage.id: (context) => HomePage(),
            RegistrationPage.id: (context) => RegistrationPage(),
            NewUser.id: (context) => NewUser(),
            WorkoutList.id:(context)=>WorkoutList(),
            WorkoutProgram.id:(context)=>WorkoutProgram(),
            WeeksList.id:(context)=>WeeksList(),
            DaysList.id:(context)=>DaysList(),
            Workout.id:(context)=>Workout(),
            VideoScreen.id:(context)=>VideoScreen(),
            MentalHealthList.id:(context)=>MentalHealthList(),
            MentalHealthSelectedOption.id:(context)=>MentalHealthSelectedOption()
          },
        );
      },
    );
  }
}
