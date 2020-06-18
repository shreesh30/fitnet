import 'package:fitnet/components/common_scaffold.dart';
import 'package:fitnet/services/apiGetter.dart';
import 'package:flutter/material.dart';

// import 'dart:convert';

class Recipe extends StatefulWidget {
  Recipe({this.recipeId, this.recipeName});
  static const String id = 'recipe';
  final String recipeName;
  final String recipeId;

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  RestClient object = RestClient();
  // Map data = {};
  // @override
  // void initState() {
  //   super.initState();

  //   // object.getRecipeImageUrl(widget.recipeId);
  // }

  @override
  Widget build(BuildContext context) {
    // data=ModalRoute.of(context).settings.arguments;
    return CommonScaffold(
      automaticallyImplyLeading: true,
      text: widget.recipeName,
      // text: data['recipeName'],
      body: FutureBuilder(
        future: object.getRecipeImageUrl(widget.recipeId),
        // future: object.getRecipeImageUrl(data['recipeId']),
        builder: (context, snapshot) {
          // String finalImageUrl=snapshot.data;
          // if(snapshot.hasError){
          //   print(snapshot.error);
          //   return Text('Failed to get response from the server');
          // }else if(snapshot.hasData){
          //   return Center(
          //     child: ListView(
          //       children: <Widget>[
          //         Image.network(finalImageUrl)
          //       ],
          //     ),
          //   );
          // }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return new Text('Error');
              else if (!snapshot.hasData) {
                return Text('');
              } else
                return ListView(
                  children: <Widget>[Image.network(snapshot.data)],
                );
          }
        },
      ),
    );
  }
}
