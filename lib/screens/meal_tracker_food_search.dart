import 'package:fitnet/models/nutrition_data.dart';
import 'package:fitnet/screens/meal_tracker_food.dart';
import 'package:fitnet/services/apiGetter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';

class MealTrackerRecipeSearch extends StatefulWidget {
  static const String id = 'meal_tracker_recipe_search';
  @override
  _MealTrackerRecipeSearchState createState() =>
      _MealTrackerRecipeSearchState();
}

class _MealTrackerRecipeSearchState extends State<MealTrackerRecipeSearch> {
  RestClient object = RestClient();
  TextEditingController controller = new TextEditingController();
  String searchedFoodName;
  List _searchResultFoodNames = [];
  List _searchResultFoodId = [];
  List _recentFoodNames = [];
  List _recentFoodId = [];
  bool showSpinner = false;

  Future onSearchTextChanged(String text) async {
    RestClient.foodNameList.clear();

    setState(() {
      _searchResultFoodNames.clear();

      searchedFoodName = text;
    });
  }

  Future searchedResult() async {
    setState(() {
      showSpinner = true;
    });
    _searchResultFoodId.clear();
    _searchResultFoodNames.clear();
    await object.getFoodInfo(searchedFoodName);
    if (searchedFoodName.isEmpty) {
      setState(() {});
      return;
    } else {
      RestClient.foodNameList.forEach((foodNameListElement) {
        setState(() {
          _searchResultFoodNames.add(foodNameListElement);
        });
      });
      setState(() {});
    }

    if (searchedFoodName.isEmpty) {
      setState(() {});
      return;
    } else {
      RestClient.foodIdList.forEach((foodIdListElement) {
        setState(() {
          _searchResultFoodId.add(foodIdListElement);
        });
      });
      setState(() {});
    }
    setState(() {
      showSpinner = false;
    });
    // print(_searchResultFoodId);
    // print(searchedFoodName);
    // print(_searchResultFoodNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
            icon: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.heightMultiplier * 3,
              color: Color(0xFFFD5739),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<NutritionData>(context,listen: false).mealName=null;
            }),
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(
              fontFamily: 'CopperPlate',
              fontSize: SizeConfig.textMultiplier * 3,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
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
                        TextStyle(fontSize: SizeConfig.textMultiplier * 2),
                  ),
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
            child: _searchResultFoodNames.length != 0 ||
                    controller.text.isNotEmpty
                ? ModalProgressHUD(
                    progressIndicator: CircularProgressIndicator(),
                    opacity: 0.0,
                    inAsyncCall: showSpinner,
                    child: ListView.builder(
                      itemCount: _searchResultFoodNames.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _recentFoodNames
                                  .add(_searchResultFoodNames[index]);
                            });

                            setState(() {
                              _recentFoodId.add(_searchResultFoodId[index]);
                            });
                            // Navigator.pushNamed(context, Recipe.id, arguments: {
                            //   'recipeName': _searchResultRecipeNames[index],
                            //   'recipeId': _searchResultRecipeId[index],
                            // });
                            // Provider.of<NutritionData>(context,listen: false).foodName=_searchResultFoodNames[index];
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) {
                                  return MealTrackerFood(
                                    foodName: _searchResultFoodNames[index],
                                    foodId: _searchResultFoodId[index],
                                    // recipeId: _searchResultRecipeId[index],
                                    // recipeName: _searchResultRecipeNames[index],
                                  );
                                },
                              ),
                            );
                          // Provider.of<NutritionData>(context,listen: false).name=_searchResultFoodNames[index];

                          },
                          child: ListTile(
                            title: Text(_searchResultFoodNames[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Roboto',
                                    fontSize: SizeConfig.textMultiplier * 2)),
                          ),
                        );
                      },
                    ),
                  )
                : _recentFoodNames.length != 0
                    ? ListView.builder(
                        itemCount: _recentFoodNames.length < 5
                            ? _recentFoodNames.length
                            : 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {

                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) {
                                    return MealTrackerFood(
                                      foodName: _recentFoodNames.reversed
                                          .toList()[index],
                                      foodId: _recentFoodId[index],
                                      // recipeId: _recentRecipesId.reversed
                                      //     .toList()[index],
                                      // recipeName: _recentRecipesName.reversed
                                      //     .toList()[index],
                                    );

                                  },
                                ),
                              );
                              // Provider.of<NutritionData>(context,listen: false).name=_recentFoodNames[index];

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
                                  _recentFoodNames.reversed.toList()[index],
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
