import 'package:custom_navigator/custom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/screens/home.dart';
import 'package:fitnet/screens/landing_page.dart';
import 'package:fitnet/screens/meal_tracker.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/user_profile.dart';
import 'package:fitnet/screens/workout_list.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/cupertino.dart';

class TabsScreen extends StatefulWidget {
  static const String id = 'tabs_screen';
  static int selectedPageIndex=0;
  final VoidCallback onSignOut;
  final FirebaseAuth auth;

  const TabsScreen({Key key, this.onSignOut, this.auth}) : super(key: key);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> pages = [
    HomePage(),
    WorkoutList(),
    MealTracker(),
    MentalHealthList(),
    UserProfile()
  ];
    int _selectedPageIndex=0;

 
 void _selectPage(int index) {
   setState(() {
          TabsScreen.selectedPageIndex = index;

   });
//      print(TabsScreen.selectedPageIndex);
  
 }

  //  String currentPage;
  // int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: pages[TabsScreen.selectedPageIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     backgroundColor: Color(0xFF242424),
    //     selectedItemColor: Color(0xFFFD5739),
    //     unselectedItemColor: Color(0xFF595959),
    //     currentIndex: TabsScreen.selectedPageIndex,
    // items: [
    //   BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.home,
    //         size: SizeConfig.heightMultiplier * 3,
    //       ),
    //       title: Text('Home')),
    //   BottomNavigationBarItem(
    //       icon: Icon(Icons.fitness_center,
    //           size: SizeConfig.heightMultiplier * 3),
    //       title: Text('Workout')),
    //   BottomNavigationBarItem(
    //       icon: Icon(Icons.fastfood, size: SizeConfig.heightMultiplier * 3),
    //       title: Text('Tracker')),
    //   BottomNavigationBarItem(
    //       icon: Icon(Icons.local_hospital,
    //           size: SizeConfig.heightMultiplier * 3),
    //       title: Text('Mental Health')),
    //   BottomNavigationBarItem(
    //       icon: Icon(Icons.person_outline,
    //           size: SizeConfig.heightMultiplier * 3),
    //       title: Text('Profile'))
    // ],
    //     onTap:_selectPage,
    //   ),
    // );

    // /////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////

    return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      currentIndex: TabsScreen.selectedPageIndex,
      onTap: _selectPage,
        activeColor: Color(0xFFFD5739),
        items: <BottomNavigationBarItem>[
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
              icon: Icon(Icons.fastfood,
                  size: SizeConfig.heightMultiplier * 3),
              title: Text('Tracker')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital,
                  size: SizeConfig.heightMultiplier * 3),
              title: Text('Mental Health')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline,
                  size: SizeConfig.heightMultiplier * 3),
              title: Text('Profile'))
        ]),
    tabBuilder: (context, index) {
      switch (index) {
        case 0:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: HomePage());
            },
          );
        case 1:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: WorkoutList());
            },
          );
        case 2:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: MealTracker());
            },
          );
        case 3:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: MentalHealthList());
            },
          );
        case 4:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: UserProfile(onSignOut: widget.onSignOut,auth: widget.auth,));
            },
          );

        default:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: HomePage());
            },
          );
      }
    });

    // /////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////

    // return CustomScaffold(
    //   scaffold: Scaffold(
    //     body: pages[_selectedPageIndex],
    //     bottomNavigationBar: BottomNavigationBar(
    //       currentIndex: _selectedPageIndex,
    //       onTap: (index) {
    //         setState(() {
    //           _selectedPageIndex=index;
    //         });
    //       },
    //       items: [
    //         BottomNavigationBarItem(
    //             icon: Icon(
    //               Icons.home,
    //               size: SizeConfig.heightMultiplier * 3,
    //             ),
    //             title: Text('Home')),
    //         BottomNavigationBarItem(
    //             icon: Icon(Icons.fitness_center,
    //                 size: SizeConfig.heightMultiplier * 3),
    //             title: Text('Workout')),
    //         BottomNavigationBarItem(
    //             icon:
    //                 Icon(Icons.fastfood, size: SizeConfig.heightMultiplier * 3),
    //             title: Text('Tracker')),
    //         BottomNavigationBarItem(
    //             icon: Icon(Icons.local_hospital,
    //                 size: SizeConfig.heightMultiplier * 3),
    //             title: Text('Mental Health')),
    //         BottomNavigationBarItem(
    //             icon: Icon(Icons.person_outline,
    //                 size: SizeConfig.heightMultiplier * 3),
    //             title: Text('Profile'))
    //       ],
    //     ),
    //   ),
    //   children: <Widget>[
    //     HomePage(),
    //     WorkoutList(),
    //     MealTracker(),
    //     MentalHealthList(),
    //     UserProfile()
    //   ],
    // );
  }
}
