import 'package:fitnet/components/common_scaffold.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  static const String id='user_profile';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      automaticallyImplyLeading: false,
      text: 'Profile',
    );
  }
}