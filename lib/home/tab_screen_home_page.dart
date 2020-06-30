import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnet/home/cupertino_home_scaffold.dart';
import 'package:fitnet/home/tab_item.dart';
import 'package:fitnet/screens/home.dart';
import 'package:fitnet/screens/meal_tracker.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/user_profile.dart';
import 'package:fitnet/screens/workout_list.dart';
import 'package:flutter/material.dart';

class TabScreenHomePage extends StatefulWidget {
  static const String id = 'tab_screen_home_page';
  // final VoidCallback signIn;
  // final VoidCallback signOut;
  // final FirebaseAuth auth;

  // const TabScreenHomePage({Key key, this.signIn, this.signOut, this.auth})
      // : super(key: key);

  @override
  _TabScreenHomePageState createState() => _TabScreenHomePageState();
}

class _TabScreenHomePageState extends State<TabScreenHomePage> {
  TabItem _currentTab = TabItem.homePage;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.homePage: GlobalKey<NavigatorState>(),
    TabItem.workoutList: GlobalKey<NavigatorState>(),
    TabItem.mealTracker: GlobalKey<NavigatorState>(),
    TabItem.mentalHealthList: GlobalKey<NavigatorState>(),
    TabItem.userProfile: GlobalKey<NavigatorState>(),
  };
  Map<TabItem, WidgetBuilder> get widgetBuilder {
    return {
      TabItem.homePage: (_) => HomePage(),
      TabItem.workoutList: (_) => WorkoutList(),
      TabItem.mealTracker: (_) => MealTracker(),
      TabItem.mentalHealthList: (_) => MentalHealthList(),
      TabItem.userProfile: (_) => UserProfile(
            // auth: widget.auth,
            // onSignOut: widget.signOut,
          
          ),
    };
  }
 
   _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem].currentState.popUntil((route)=>route.isFirst);
    } else {
     setState(()=>_currentTab=tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKeys[_currentTab].currentState.maybePop();
      },
      child: CupertinoHomeScaffold(
          currentTab: _currentTab,
          onSelectTab: _select,
          widgetBuilder: widgetBuilder,
          navigatorKeys: navigatorKeys),
    );
  }
}
