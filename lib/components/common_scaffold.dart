import 'package:fitnet/screens/home.dart';
import 'package:fitnet/screens/meal_tracker.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/user_profile.dart';
import 'package:fitnet/screens/workout_list.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CommonScaffold extends StatefulWidget {
  CommonScaffold(
      {this.text,
      this.automaticallyImplyLeading = false,
      this.body,
      this.appbar = false});

  final String text;
  final bool automaticallyImplyLeading;
  final Widget body;
  final bool appbar;
  static const String id = 'common_scaffold';

  @override
  _CommonScaffoldState createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  final tabs = [
    HomePage(),
    WorkoutList(),
    MealTracker(),
    MentalHealthList(),
    UserProfile()
  ];
  int currentIndex = 0;
  PersistentTabController _controller;
  List<Widget> _buildScreens() {
    return [
      HomePage(),
      WorkoutList(),
      MealTracker(),
      MentalHealthList(),
      UserProfile()
    ];
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appbar == false
            ? null
            : AppBar(
                centerTitle: true,
                automaticallyImplyLeading: widget.automaticallyImplyLeading,
                leading: widget.automaticallyImplyLeading
                    ? IconButton(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 2),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: SizeConfig.heightMultiplier * 3,
                          color: Color(0xFFFD5739),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                    : null,
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        fontFamily: 'CopperPlate',
                        fontSize: SizeConfig.textMultiplier * 3,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                backgroundColor: Color(0xFF0F0F0F),
              ),
        body: widget.body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Color(0xFF242424),
          selectedItemColor: Color(0xFFFD5739),
          unselectedItemColor: Color(0xFF595959),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: SizeConfig.heightMultiplier * 3,
                ),
                title: Text('home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center,
                    size: SizeConfig.heightMultiplier * 3),
                title: Text('Workout')),
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.fastfood, size: SizeConfig.heightMultiplier * 3),
                title: Text('Tracker')),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital,
                    size: SizeConfig.heightMultiplier * 3),
                title: Text('Mental Health')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,
                    size: SizeConfig.heightMultiplier * 3),
                title: Text('Profile'))
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ));
  }
}
