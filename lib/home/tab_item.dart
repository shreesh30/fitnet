import 'package:flutter/material.dart';

enum TabItem {
  homePage,
  workoutList,
  mealTracker,
  mentalHealthList,
  userProfile
}

class TabItemData {
  final String title;
  final IconData icon;

  const TabItemData({this.title, this.icon});

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.homePage: TabItemData(icon: Icons.home, title: 'Home'),
    TabItem.workoutList:
        TabItemData(icon: Icons.fitness_center, title: 'Workout'),
    TabItem.mealTracker: TabItemData(icon: Icons.restaurant_menu, title: 'Tracker'),
    TabItem.mentalHealthList:
        TabItemData(icon: Icons.local_hospital, title: 'Mental Health'),
    TabItem.userProfile: TabItemData(icon: Icons.person, title: 'Profile'),
  };
}
