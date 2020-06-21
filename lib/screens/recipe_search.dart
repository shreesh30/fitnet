
import 'package:fitnet/screens/recipe.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/services/apiGetter.dart';

// import 'package:html/dom.dart';

class RecipeSearch extends StatefulWidget {
  static const String id = 'recipe_search';
  @override
  _RecipeSearchState createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  RestClient object = RestClient();
  TextEditingController controller = new TextEditingController();
  var recipeNameFinalListReference = RestClient.recipeNameFinalList;
  var recipeIdFinalListReference = RestClient.recipeIdFinalList;
  String searchedRecipeName;
  List _searchResultRecipeNames = [];
  List _recentRecipesName = [];
  List _searchResultRecipeId = [];
  List _recentRecipesId = [];

  Future onSearchTextChanged(String text) async {
    recipeNameFinalListReference.clear();

    setState(() {
      _searchResultRecipeNames.clear();
      recipeNameFinalListReference.clear();
      recipeIdFinalListReference.clear();
      searchedRecipeName = text;
    });
  }

  Future searchedResult() async {
    _searchResultRecipeId.clear();
    _searchResultRecipeNames.clear();
    await object.getRecipeNameAndId(searchedRecipeName);
    if (searchedRecipeName.isEmpty) {
      setState(() {});
      return;
    } else {
      recipeNameFinalListReference.forEach((recipeNameFinalListElement) {
        setState(() {
          _searchResultRecipeNames.add(recipeNameFinalListElement);
        });
        // if (!_searchResultRecipeNames.contains(recipeNameFinalListElement)) {
        //   if (recipeNameFinalListElement
        //           .toLowerCase()
        //           .contains(searchedRecipeName.toLowerCase()) ||
        //       recipeNameFinalListElement
        //           .toUpperCase()
        //           .contains(searchedRecipeName.toUpperCase())) {
        //     setState(() {
        //       _searchResultRecipeNames.add(recipeNameFinalListElement);
        //     });
        //   }
        // }
      });
      setState(() {});
    }

    if (searchedRecipeName.isEmpty) {
      setState(() {});
      return;
    } else {
      recipeIdFinalListReference.forEach((recipeIdFinalListElement) {
        // if (!_searchResultRecipeId.contains(recipeIdFinalListElement)) {
        //   setState(() {
        //     _searchResultRecipeId.add(recipeIdFinalListElement);
        //   });
        // }
        setState(() {
          _searchResultRecipeId.add(recipeIdFinalListElement);
        });
      });
      setState(() {});
    }
    // print(_searchResultRecipeId);
    // print(_searchResultRecipeNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Recipes',
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
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
                  onEditingComplete: () {
                    searchedResult();
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
            child: _searchResultRecipeNames.length != 0 ||
                    controller.text.isNotEmpty
                ? ListView.builder(
                    itemCount: _searchResultRecipeNames.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _recentRecipesName
                                .add(_searchResultRecipeNames[index]);
                          });

                          setState(() {
                            _recentRecipesId.add(_searchResultRecipeId[index]);
                          });
                          // Navigator.pushNamed(context, Recipe.id, arguments: {
                          //   'recipeName': _searchResultRecipeNames[index],
                          //   'recipeId': _searchResultRecipeId[index],
                          // });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Recipe(
                                  recipeId: _searchResultRecipeId[index],
                                  recipeName: _searchResultRecipeNames[index],
                                );
                              },
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(_searchResultRecipeNames[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2)),
                        ),
                      );
                    },
                  )
                : _recentRecipesName.length != 0
                    ? ListView.builder(
                        itemCount: _recentRecipesName.length < 5
                            ? _recentRecipesName.length
                            : 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Recipe(
                                      recipeId: _recentRecipesId.reversed
                                          .toList()[index],
                                      recipeName: _recentRecipesName.reversed
                                          .toList()[index],
                                    );
                                  },
                                ),
                              );
                              // Navigator.pushNamed(context, Recipe.id,
                              //     arguments: {
                              //       'recipeName': _recentRecipesName[index],
                              //       'recipeId': _recentRecipesId[index],
                              //     });
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
                                  _recentRecipesName.reversed.toList()[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto',
                                      fontSize: SizeConfig.textMultiplier * 2)),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text('No Recent Searches',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Roboto',
                                fontSize: SizeConfig.textMultiplier * 2)),
                      ),
          )
        ],
      ),
    );
  }
}
