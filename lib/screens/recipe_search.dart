
import 'package:fitnet/components/common_scaffold.dart';
import 'package:fitnet/constants.dart';
import 'package:fitnet/models/search_food_items.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/services/apiGetter.dart';
import 'package:fitnet/models/search_food_items.dart';
import 'package:fitnet/services/api.dart';
import 'package:fitnet/services/apiGetter.dart';
import 'dart:convert';
import 'package:fitnet/widgets/search_bar.dart';

List<String> _searchResult = [];
List recipeName = [];
List recentRecipeName=['butter chicken','dal','paneer tikka','paneer butter masala'];
// List<SearchFoodItem> list = [];

class RecipeSearch extends StatefulWidget {
  static const String id = 'recipe_search';
  @override
  _RecipeSearchState createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  RestClient object = RestClient();
  TextEditingController controller = new TextEditingController();
  var recipeNameFinalListReference = RestClient.recipeNameFinalList;
  String searchedRecipeName;
  SearchBarController _searchBarController=SearchBarController();

  Future onSearchTextChanged(String text) async {
    // object.getRecipeName(text);
    // _searchResult.clear();
    // if (text.isEmpty) {
    //   setState(() {});
    //   return;
    // }

    // for (int i = 0; i < listReference.length; i++) {
    //   recipeName.add(listReference[i]);
    // }
    // print(recipeName);
    // // RestClient.list.forEach((recipeName) {
    // //   if (list.recipeName.contains(text)) _searchResult.add(recipeName);
    // // });

    // setState(() {});

    _searchResult.clear();
    setState(() {
      searchedRecipeName = text;
    });

  }



  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      text: 'Recipes',
      automaticallyImplyLeading: false,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 2,
                horizontal: SizeConfig.widthMultiplier * 2),
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.search,
                  size: SizeConfig.heightMultiplier * 3,
                ),
                title: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'Search Recipes',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.heightMultiplier * 1.5,
                            horizontal: SizeConfig.widthMultiplier * 2),
                        hintStyle:
                            TextStyle(fontSize: SizeConfig.textMultiplier * 2)),
                    onChanged: (value)async{
                      await onSearchTextChanged(value);
                      

                    },onEditingComplete:()async{
                     await object.getRecipeName(searchedRecipeName);
                    },),
                trailing: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    size: SizeConfig.heightMultiplier * 3,
                  ),
                  onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



