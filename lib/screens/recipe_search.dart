import 'package:fitnet/components/common_scaffold.dart';
import 'package:fitnet/screens/recipe.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/services/apiGetter.dart';

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
  List _searchResult = [];
  List _recentRecipes = [];

  Future onSearchTextChanged(String text) async {
    recipeNameFinalListReference.clear();

    setState(() {
      _searchResult.clear();
      recipeNameFinalListReference.clear();
      searchedRecipeName = text;
    });
  }

  Future searchedResult() async {
    await object.getRecipeName(searchedRecipeName);

    // if (searchedRecipeName.isEmpty) {
    //   setState(() {});
    //   return;
    // } else {
    //   recipeNameFinalListReference.forEach((recipeName) {
    //     if (recipeName
    //             .toLowerCase()
    //             .contains(searchedRecipeName.toLowerCase()) ||
    //         recipeName
    //             .toUpperCase()
    //             .contains(searchedRecipeName.toUpperCase())) {
    //       _searchResult.add(recipeName);
    //     }
    //   });
    //   setState(() {});
    // }

    if (searchedRecipeName.isEmpty) {
      setState(() {});
      return;
    } else {
      recipeNameFinalListReference.forEach((recipeNameFinalListElement) {
        if (!_searchResult.contains(recipeNameFinalListElement)) {
          if (recipeNameFinalListElement
                  .toLowerCase()
                  .contains(searchedRecipeName.toLowerCase()) ||
              recipeNameFinalListElement
                  .toUpperCase()
                  .contains(searchedRecipeName.toUpperCase())) {
            _searchResult.add(recipeNameFinalListElement);
          }
        }
      });
      setState(() {});
    }
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
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Search Recipes',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 1.5,
                          horizontal: SizeConfig.widthMultiplier * 2),
                      hintStyle:
                          TextStyle(fontSize: SizeConfig.textMultiplier * 2)),
                  onChanged: (value) async {
                    await onSearchTextChanged(value);
                  },
                  onEditingComplete: () async {
                    await searchedResult();
                  },
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    size: SizeConfig.heightMultiplier * 3,
                  ),
                  onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recipe(
                                        recipeName: _searchResult[index],
                                      )));
                          if (!_recentRecipes.contains(_searchResult[index])) {
                            _recentRecipes.add(_searchResult[index]);
                          }
                        },
                        child: ListTile(
                          title: Text(_searchResult[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2)),
                        ),
                      );
                    })
                : _recentRecipes.length != 0
                    ? ListView.builder(
                        itemCount: _recentRecipes.length < 5
                            ? _recentRecipes.length
                            : 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Recipe(
                                            recipeName: _recentRecipes[index],
                                          )));
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 4,
                                  bottom: SizeConfig.heightMultiplier * 1.5),
                              leading: Icon(
                                Icons.history,
                                size: SizeConfig.heightMultiplier * 3,
                              ),
                              title: Text(
                                  _recentRecipes.reversed.toList()[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto',
                                      fontSize: SizeConfig.textMultiplier * 2)),
                            ),
                          );
                        },
                      )
                    : Text('No Recent Searches',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Roboto',
                            fontSize: SizeConfig.textMultiplier * 2)),
          )
        ],
      ),
    );
  }
}
