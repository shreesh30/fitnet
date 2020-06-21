// import 'package:fitnet/screens/home.dart';
// import 'package:fitnet/screens/meal_tracker.dart';
// import 'package:fitnet/screens/mental_health_list.dart';
// import 'package:fitnet/screens/user_profile.dart';
// import 'package:fitnet/screens/workout_list.dart';
// import 'package:fitnet/size_config.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/models/neumorphic-properties.widget.dart';
// import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
// import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
// import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/neumorphic-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/simple-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-1-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-10-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-2-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-3-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-4-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-5-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-6-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-7-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-8-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/style-9-bottom-nav-bar.widget.dart';
// import 'package:persistent_bottom_nav_bar/nav-bar-styles/styles.dart';
// import 'package:persistent_bottom_nav_bar/neumorphic-package-by-serge-software/neumorphic-card.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';
// import 'package:persistent_bottom_nav_bar/utils/functions.utils.dart';
// import 'package:persistent_bottom_nav_bar/utils/utils.dart';

// class BottomNavBar extends StatefulWidget {
//   static int currentIndex=0;
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
  
 
//   PersistentTabController _controller;

//   List<Widget> _buildScreens() {
//     return [
//       HomePage(),
//       WorkoutList(),
//       MealTracker(),
//       MentalHealthList(),
//       UserProfile()
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColor: Color(0xFFFD5739),
//         inactiveColor: Color(0xFF595959),
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.fitness_center),
//         title: ("Workout"),
//         activeColor: Color(0xFFFD5739),
//         inactiveColor: Color(0xFF595959),
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.fastfood),
//         title: ("Tracker"),
//         activeColor: Color(0xFFFD5739),
//         inactiveColor: Color(0xFF595959),
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.local_hospital),
//         title: ("Mental Health"),
//         activeColor: Color(0xFFFD5739),
//         inactiveColor: Color(0xFF595959),
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.person_outline),
//         title: ("Profile"),
//         activeColor: Color(0xFFFD5739),
//         inactiveColor: Color(0xFF595959),
//       ),
//     ];
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//     // return PersistentTabView(
//     //     backgroundColor: Color(0xFF242424),
//     //     screens: _buildScreens(),
//     //     items: _navBarsItems(),
//     //     controller: _controller,
//     //     iconSize: 26.0,
//     //     navBarCurve: NavBarCurve.upperCorners,
//     //     showElevation: true,
//     //     confineInSafeArea: true,
//     //     handleAndroidBackButtonPress: true,
//     //     navBarStyle: NavBarStyle.style1,
//     //     onItemSelected: (index) {
//     //       print(index);
//     //     });
//   }
// }
