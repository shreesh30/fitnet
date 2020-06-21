import 'package:fitnet/screens/home.dart';
import 'package:fitnet/screens/meal_tracker.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/user_profile.dart';
import 'package:fitnet/screens/workout_list.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';

class TabsScreen extends StatefulWidget {
  static const String id='tabs_screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> pages=[
    HomePage(),
    WorkoutList(),
    MealTracker(),
    MentalHealthList(),
    UserProfile()
  ];

  int _selectedPageIndex=0;
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF242424),
        selectedItemColor: Color(0xFFFD5739),
        unselectedItemColor: Color(0xFF595959),
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: SizeConfig.heightMultiplier * 3,
              ),
              title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center,
                  size: SizeConfig.heightMultiplier * 3),
              title: Text('Workout')),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood, size: SizeConfig.heightMultiplier * 3),
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
        onTap:_selectPage,
      ),
    );
  }
}
