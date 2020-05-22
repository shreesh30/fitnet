import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  static const String id='new_user_page';
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('new user')
    );
  }
}