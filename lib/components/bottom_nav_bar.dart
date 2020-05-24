import 'package:flutter/material.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF272727),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center), title: Text('Workout')),
        BottomNavigationBarItem(
            icon: Icon(Icons.fastfood), title: Text('Tracker')),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital), title: Text('Mental Health')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }
}