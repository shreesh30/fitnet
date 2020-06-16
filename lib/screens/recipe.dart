import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  Recipe({this.recipeName});

  static const String id='recipe';
  final String recipeName;
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.recipeName),
    );
  }
}