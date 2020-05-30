import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BottomNavigationBar(
      backgroundColor: Color(0xFF242424),
      selectedItemColor: Color(0xFFFD5739),
      unselectedItemColor: Color(0xFF595959),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,size: SizeConfig.heightMultiplier*3,), title: Text('home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center,size: SizeConfig.heightMultiplier*3), title: Text('Workout')),
        BottomNavigationBarItem(
            icon: Icon(Icons.fastfood,size: SizeConfig.heightMultiplier*3), title: Text('Tracker')),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital,size: SizeConfig.heightMultiplier*3), title: Text('Mental Health')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,size: SizeConfig.heightMultiplier*3), title: Text('Profile'))
      ],

    );
  }
}