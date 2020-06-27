import 'package:fitnet/home/tab_item.dart';
import 'package:fitnet/screens/home.dart';
import 'package:fitnet/screens/meal_tracker.dart';
import 'package:fitnet/screens/mental_health_list.dart';
import 'package:fitnet/screens/user_profile.dart';
import 'package:fitnet/screens/workout_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({Key key, this.currentTab, this.onSelectTab,this.widgetBuilder,this.navigatorKeys})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem,WidgetBuilder> widgetBuilder;
  final Map<TabItem,GlobalKey<NavigatorState>> navigatorKeys;
  

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            onTap: (index) => onSelectTab(TabItem.values[index]),
            items: [
              _buildItem(TabItem.homePage),
              _buildItem(TabItem.workoutList),
              _buildItem(TabItem.mealTracker),
              _buildItem(TabItem.mentalHealthList),
              _buildItem(TabItem.userProfile),
            ]),
        tabBuilder: (context, index){
          final item=TabItem.values[index];
          return CupertinoTabView(
            navigatorKey:navigatorKeys[item],
            builder:(context) => widgetBuilder[item](context),
          );
        },);
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Color(0xFFFD5739) : Colors.grey;
    return BottomNavigationBarItem(
        icon: Icon(
          itemData.icon,
          color: color,
        ),
        title: Text(
          itemData.title,
          style: TextStyle(color: color),
        ));
  }
}
