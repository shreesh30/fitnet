import 'package:fitnet/components/common_scaffold.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';

class RecipeSearch extends StatefulWidget {
  static const String id = 'recipe_search';
  @override
  _RecipeSearchState createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      text: 'Search Recipes',
      automaticallyImplyLeading: false,
      actions: <Widget>[IconButton(icon: Icon(Icons.search,size: SizeConfig.heightMultiplier * 3,), onPressed:(){})],

    );
  }
}

class DataSearch extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: implement buildActions
      throw UnimplementedError();
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // TODO: implement buildLeading
      throw UnimplementedError();
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // TODO: implement buildResults
      throw UnimplementedError();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

}