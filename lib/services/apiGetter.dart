import 'dart:async';
import 'dart:convert';
import 'package:fitnet/services/api.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';

class RestClient {
  String consumerKey;

  String consumerKeySecret;
  static List recipeName = [];
  static List recipeDescription = [];
  static List recipeNameList = [];
  static List recipeNameFinalList = [];
  static List recipeIdList = [];
  static List recipeIdFinalList = [];
  static List directionList = [];
  static List finalResults = [];
  static List<ListTile> directionListTile = [];

  RestClient() {
    this.consumerKey = '0f96f7fee7a7414f96287863baebd11f';
    this.consumerKeySecret = '79a934b831e54641801a001d7320c89d';
  }

  Future getRecipeNameAndId(String query) async {
    FatSecretApi recipeSearch = FatSecretApi(
      this.consumerKey,
      this.consumerKeySecret,
      "",
      "",
    );

    var result = await recipeSearch
        .request({"search_expression": query, "method": "recipes.search"})
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json["recipes"])
        .then((json) => json["recipe"])
        .catchError((err) {
          print(err);
        });

    // Create a POJO class and parse it
    if (result == null) {
      return null;
    } else {
      recipeIdFinalList.clear();
      recipeIdList.clear();
      recipeNameList.clear();
      recipeNameFinalList.clear();
      await result.forEach((element) {
        recipeNameList.add(element);
        recipeIdList.add(element);
      });

      if (recipeNameFinalList.isNotEmpty && recipeIdFinalList.isNotEmpty) {
        recipeNameList.forEach((element) {
          if (!recipeNameFinalList.contains(element['recipe_name'])) {
            recipeNameFinalList.add(element['recipe_name']);
          }
        });
        recipeIdList.forEach((element) {
          if (!recipeIdFinalList.contains(element['recipe_id'])) {
            recipeIdFinalList.add(element['recipe_id']);
          }
        });
      } else {
        recipeNameList.forEach((element) {
          recipeNameFinalList.add(element['recipe_name']);
        });
        recipeIdList.forEach((element) {
          recipeIdFinalList.add(element['recipe_id']);
        });
      }
    }
  }

  Future getRecipeImageUrl(String recipeId) async {
    FatSecretApi foodItem = FatSecretApi(
      this.consumerKey,
      this.consumerKeySecret,
      "",
      "",
    );
    directionList.clear();
    finalResults.clear();
    directionList.clear();
    var result = await foodItem
        .request({"recipe_id": recipeId, "method": "recipe.get"})
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json["recipe"])
        .catchError((err) {
          print(err);
        });

    // print(result['directions']['direction']);
    //  print(result['serving_sizes']['serving']['fat']);
    if (result != null) {
      var directionResult = await result['directions']['direction'];
      var cookingTimeResult = await result['cooking_time_min'];
      var imageResult = await result['recipe_images'];
      var caloriesResult = await result['serving_sizes']['serving']['calories'];
      var carbsResult =
          await result['serving_sizes']['serving']['carbohydrate'];
      var proteinResult = await result['serving_sizes']['serving']['protein'];
      var fatResult = await result['serving_sizes']['serving']['fat'];

      // 1.image result
      // 2.cooking time
      // 3.directions
      // 4.calories
      // 5.carbs
      // 6.Proteins
      // 7. fats
      if (await imageResult == null ||
          await imageResult == [] ||
          await imageResult['recipe_image'] == null) {
        finalResults.add(null);
      } else if (imageResult['recipe_image'].runtimeType.toString() ==
          'List<dynamic>') {
        var recipeImageListResult = await imageResult['recipe_image'][0];
        finalResults.add(await recipeImageListResult);
      } else {
        var recipeImageResult = await imageResult['recipe_image'];
        finalResults.add(await recipeImageResult);
      }

      if (cookingTimeResult == null) {
        finalResults.add(null);
      } else {
        finalResults.add(cookingTimeResult);
      }

      if (directionResult == null) {
        finalResults.add(null);
      } else if (directionResult.runtimeType.toString() == 'List<dynamic>') {
        await directionResult.forEach((direction) {
          directionList.add(direction['direction_description']);
        });
        finalResults.add(directionList);
        for (int i = 0; i < directionList.length; i++) {
          directionListTile.add(ListTile(
              title: Text('${i + 1} . ${directionList[i]}',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300))));
        }
      } else {
        // directionListTile.add(ListTile(title: Text('1. $directionList'),));
        finalResults.add(directionList);
      }
      if (caloriesResult == null) {
        finalResults.add(null);
      } else {
        finalResults.add(caloriesResult);
      }
      if (carbsResult == null) {
        finalResults.add(null);
      } else {
        finalResults.add(carbsResult);
      }
      if (proteinResult == null) {
        finalResults.add(null);
      } else {
        finalResults.add(proteinResult);
      }
      if (fatResult == null) {
        finalResults.add(null);
      } else {
        finalResults.add(fatResult);
      }

      // print(finalResults);

      return finalResults;

      // if (await imageResult == null ||
      //     await imageResult == [] ||
      //     await imageResult['recipe_image'] == null ||
      //         await cookingTimeResult == null
      //        ) {
      //   return null;
      // } else if (imageResult['recipe_image'].runtimeType.toString() ==
      //     'List<dynamic>') {
      //   var recipeImageListResult = await imageResult['recipe_image'][0];
      //   await directionResult.forEach((direction) {
      //     directionList.add(direction['direction_description']);
      //   });

      //   // print(directionList);
      //   return [
      //     await recipeImageListResult,
      //     await cookingTimeResult,
      //     directionList
      //   ];
      // } else {
      //   var recipeImageResult = await imageResult['recipe_image'];
      //   await directionResult.forEach((direction) {
      //     directionList.add(direction['direction_description']);
      //   });

      //   // print(directionList);
      //   return [
      //     await recipeImageResult,
      //     await cookingTimeResult,
      //     directionList
      //   ];
      // }
    }
  }

  //  Future getFood(int foodId) async {
  //    FatSecretApi foodItem = FatSecretApi(
  //      this.consumerKey,
  //      this.consumerKeySecret,
  //      "",
  //      "",
  //    );

  //    var result = await foodItem
  //        .request({"recipe_id": foodId.toString(), "method": "recipe.get"})
  //        .then((res) => res.body)
  //        .then(json.decode)
  //        .then((json) => json["recipe"])
  //        .catchError((err) {
  //          print(err);
  //        });

  //    print(result);
  //  }

}

//void main(List<String> args) {
//  RestClient object = RestClient();
//  //  object.getFood(33691);
//  //    object.getRecipeId('Brown Lentil Dal');
//  // object.recipeList(99);
//  //    object.getRecipeName('Brown Lentil Dal');
//  object.getRecipeImageUrl('27');
//  //   object.getRecipeNameAndId('chicken');
//  //   object.getRecipeNameAndId('dal');
//  //   object.getRecipeNameAndId('chicken');
//}
