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
  static List finalRecipeResults = [];
  static List<ListTile> directionListTile = [];
  static List ingredientList = [];
  static List<Text> ingredientListTile = [];
  static List foodNameList = [];
  static List foodIdList = [];
  static List finalFoodResults = [];
  static List servingDescriptionList = [];
  static List<DropdownMenuItem> servingDescriptionDropdownItems = [];
  static List caloriesList = [];
  static List carbsList = [];
  static List fatsList = [];
  static List proteinsList = [];
  static List saturatedFatsList = [];
  static List polyUnsaturatedFatsList = [];
  static List monoUnsaturatedFatsList = [];
  static List transFatList = [];
  static List cholesterolList = [];
  static List sodiumList = [];
  static List potassiumList = [];
  static List fiberList = [];
  static List sugarsList = [];
  static List vitaminAList = [];
  static List vitaminCList = [];
  static List calciumList = [];
  static List ironList = [];

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
    // print(result.runtimeType.toString());
    // print(result);

    // Create a POJO class and parse it
    if (result == null) {
      return null;
    } else {
      recipeIdFinalList.clear();
      recipeIdList.clear();
      recipeNameList.clear();
      recipeNameFinalList.clear();
      if (result.runtimeType.toString() == 'List<dynamic>') {
        await result.forEach((element) {
          recipeNameList.add(element);
          recipeIdList.add(element);
        });
      } else {
        recipeNameList.add(await result['recipe_name']);
        recipeIdList.add(await result['recipe_id']);
      }

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
        if (recipeNameList.length > 1 && recipeIdList.length > 1) {
          recipeNameList.forEach((element) {
            recipeNameFinalList.add(element['recipe_name']);
          });
          recipeIdList.forEach((element) {
            recipeIdFinalList.add(element['recipe_id']);
          });
        }
        else{
          recipeNameList.forEach((element){
            recipeNameFinalList.add(element);
          });
          recipeIdList.forEach((element){
            recipeIdFinalList.add(element);
          });
        }
      }
    }
  }

  Future getRecipeInfo(String recipeId) async {
    FatSecretApi foodItem = FatSecretApi(
      this.consumerKey,
      this.consumerKeySecret,
      "",
      "",
    );
    finalRecipeResults.clear();
    directionList.clear();
    ingredientList.clear();
    ingredientListTile.clear();
    directionListTile.clear();
    var result = await foodItem
        .request({"recipe_id": recipeId, "method": "recipe.get"})
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json["recipe"])
        .catchError((err) {
          print(err);
        });
  
    if (result != null) {
      var directionResult = await result['directions']['direction'];
      var cookingTimeResult = await result['cooking_time_min'];
      var imageResult = await result['recipe_images'];
      var caloriesResult = await result['serving_sizes']['serving']['calories'];
      var carbsResult =
          await result['serving_sizes']['serving']['carbohydrate'];
      var proteinResult = await result['serving_sizes']['serving']['protein'];
      var fatResult = await result['serving_sizes']['serving']['fat'];
      var ingredientsResult = await result['ingredients']['ingredient'];
      // 1.image result
      // 2.cooking time
      // 3.directions
      // 4.calories
      // 5.carbs
      // 6.Proteins
      // 7. fats
      // 8. ingredients

      if (await imageResult == null ||
          await imageResult == [] ||
          await imageResult['recipe_image'] == null) {
        finalRecipeResults.add(null);
      } else if (imageResult['recipe_image'].runtimeType.toString() ==
          'List<dynamic>') {
        var recipeImageListResult = await imageResult['recipe_image'][0];
        finalRecipeResults.add(await recipeImageListResult);
      } else {
        var recipeImageResult = await imageResult['recipe_image'];
        finalRecipeResults.add(await recipeImageResult);
      }

      if (cookingTimeResult == null) {
        finalRecipeResults.add(null);
      } else {
        finalRecipeResults.add(cookingTimeResult);
      }

      if (directionResult == null) {
        finalRecipeResults.add(null);
      } else if (directionResult.runtimeType.toString() == 'List<dynamic>') {
        await directionResult.forEach((direction) {
          directionList.add(direction['direction_description']);
        });
        finalRecipeResults.add(directionList);
        for (int i = 0; i < directionList.length; i++) {
          directionListTile.add(
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4),
              title: Text(
                '${i + 1} . ${directionList[i]}',
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300),
              ),
            ),
          );
        }
      } else {
        directionListTile.add(ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
          title: Text('1. ${directionResult['direction_description']}',
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 2,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300)),
        ));
        finalRecipeResults.add(directionListTile);
      }
      if (caloriesResult == null) {
        finalRecipeResults.add(null);
      } else {
        finalRecipeResults.add(caloriesResult);
      }
      if (carbsResult == null) {
        finalRecipeResults.add(null);
      } else {
        finalRecipeResults.add(carbsResult);
      }
      if (proteinResult == null) {
        finalRecipeResults.add(null);
      } else {
        finalRecipeResults.add(proteinResult);
      }
      if (fatResult == null) {
        finalRecipeResults.add(null);
      } else {
        finalRecipeResults.add(fatResult);
      }
      if (ingredientsResult == null) {
        finalRecipeResults.add(null);
      } else if (ingredientsResult.runtimeType.toString() == 'List<dynamic>') {
        await ingredientsResult.forEach((ingredient) {
          ingredientList.add(ingredient['ingredient_description']);
        });
        finalRecipeResults.add(ingredientList);
        for (int i = 0; i < ingredientList.length; i++) {
          ingredientListTile.add(
            Text(
              '${i + 1} . ${ingredientList[i]}',
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 2,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300),
            ),
          );
        }
      }

      return finalRecipeResults;
    }
  }

  Future getFoodInfo(String foodName) async {
    foodNameList.clear();
    foodIdList.clear();

    FatSecretApi foodItem = FatSecretApi(
      this.consumerKey,
      this.consumerKeySecret,
      "",
      "",
    );
  
    var result = await foodItem
        .request({
          "format": 'json',
          "method": "foods.search",
          'search_expression': foodName
        })
        .then((res) => res.body)
        .then(json.decode)
        .catchError((err) {
          print(err);
        });
    if (result != null) {

      if (result.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        result['foods']['food'].forEach((foodItem) {
          foodNameList.add(foodItem['food_name']);
        });
        result['foods']['food'].forEach((foodItem) {
          foodIdList.add(foodItem['food_id']);
        });
      }
    }
  }

  Future getFood(foodId) async {
    servingDescriptionList.clear();
    finalFoodResults.clear();
    servingDescriptionDropdownItems.clear();
  
    caloriesList.clear();
    carbsList.clear();
    proteinsList.clear();
    fatsList.clear();
    saturatedFatsList.clear();
    polyUnsaturatedFatsList.clear();
    monoUnsaturatedFatsList.clear();
    transFatList.clear();
    cholesterolList.clear();
    sodiumList.clear();
    potassiumList.clear();
    fiberList.clear();
    sugarsList.clear();
    vitaminAList.clear();
    vitaminCList.clear();
    calciumList.clear();
    ironList.clear();

    FatSecretApi foodItem = FatSecretApi(
      this.consumerKey,
      this.consumerKeySecret,
      "",
      "",
    );
    var result = await foodItem
        .request({"format": 'json', "method": "food.get", 'food_id': foodId})
        .then((res) => res.body)
        .then(json.decode)
        .catchError((err) {
          print(err);
        });
  

    if (result != null) {


      var servingDescription = await result['food']['servings']['serving'];
      var caloriesResult = await result['food']['servings']['serving'];
      var carbsResult = await result['food']['servings']['serving'];
      var fatsResult = await result['food']['servings']['serving'];
      var proteinsResult = await result['food']['servings']['serving'];
      var saturatedFatsResult = await result['food']['servings']['serving'];
      var polyUnsaturatedFatsResult =
          await result['food']['servings']['serving'];
      var monoUnsaturatedFatsResult =
          await result['food']['servings']['serving'];
      var transFatsResult = await result['food']['servings']['serving'];
      var cholesterolResult = await result['food']['servings']['serving'];
      var sodiumResult = await result['food']['servings']['serving'];
      var potassiumResult = await result['food']['servings']['serving'];
      var fiberResult = await result['food']['servings']['serving'];
      var sugarsResult = await result['food']['servings']['serving'];
      var vitaminAResult = await result['food']['servings']['serving'];
      var vitaminCResult = await result['food']['servings']['serving'];
      var calciumResult = await result['food']['servings']['serving'];
      var ironResult = await result['food']['servings']['serving'];

      //1.serving description
      //2.calories
      //3.carbs
      // 4.fat
      // 5.protein
      // 6.saturated fat
      // 7. polyunsaturated fat
      // 8.monounsaturated fat
      // 9. trans fat
      // 10.cholesterol
      // 11.sodium
      // 12.potassium
      // 13.fiber
      // 14.sugars
      // 15.vitamin A
      // 16.vitamin C
      // 17.calcium
      // 18.iron

      if (await servingDescription == null) {
        finalFoodResults.add(null);
      } else if (servingDescription.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
    
        servingDescriptionList
            .add(await servingDescription['serving_description']);
        servingDescriptionDropdownItems.add(DropdownMenuItem(
            child: Text(await servingDescription['serving_description'])));
        finalFoodResults.add(servingDescriptionDropdownItems);
      } else {
        await servingDescription.forEach((servingDesc) {
          servingDescriptionList.add(servingDesc['serving_description']);
        });
        servingDescriptionList.forEach((element) {
          servingDescriptionDropdownItems.add(DropdownMenuItem(
              value: element,
              child: Text(
                element,style: TextStyle(fontFamily: 'Roboto',fontSize: SizeConfig.textMultiplier*2,fontWeight: FontWeight.w300),
              )));
        });
        finalFoodResults.add(servingDescriptionDropdownItems);
      }
      if (await caloriesResult == null) {
        finalFoodResults.add(null);
      } else if (caloriesResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        caloriesList.add(await caloriesResult['calories']);
        finalFoodResults.add(caloriesList);
      } else {
        await caloriesResult.forEach((value) {
          caloriesList.add(value['calories']);
        });
        finalFoodResults.add(caloriesList);
      }
      if (await carbsResult == null) {
        finalFoodResults.add(null);
      } else if (carbsResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        carbsList.add(await carbsResult['carbohydrate']);
        finalFoodResults.add(carbsList);
      } else {
        await carbsResult.forEach((value) {
          carbsList.add(value['carbohydrate']);
        });
        finalFoodResults.add(carbsList);
      }
      if (await fatsResult == null) {
        finalFoodResults.add(null);
      } else if (fatsResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        fatsList.add(await fatsResult['fat']);
        finalFoodResults.add(fatsList);
      } else {
        await fatsResult.forEach((value) {
          fatsList.add(value['fat']);
        });
        finalFoodResults.add(fatsList);
      }
      if (await proteinsResult == null) {
        finalFoodResults.add(null);
      } else if (proteinsResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        proteinsList.add(await proteinsResult['protein']);
        finalFoodResults.add(proteinsList);
      } else {
        await proteinsResult.forEach((value) {
          proteinsList.add(value['protein']);
        });
        finalFoodResults.add(proteinsList);
      }
      if (await saturatedFatsResult == null) {
        saturatedFatsList.add(null);
        finalFoodResults.add(saturatedFatsList);
      } else if (saturatedFatsResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        saturatedFatsList.add(await saturatedFatsResult['saturated_fat']);
        finalFoodResults.add(saturatedFatsList);
      } else {
        await saturatedFatsResult.forEach((value) {
          saturatedFatsList.add(value['saturated_fat']);
        });
        finalFoodResults.add(saturatedFatsList);
      }
      if (await polyUnsaturatedFatsResult == null) {
        polyUnsaturatedFatsList.add(null);
        finalFoodResults.add(polyUnsaturatedFatsList);
      } else if (polyUnsaturatedFatsResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        polyUnsaturatedFatsList
            .add(await polyUnsaturatedFatsResult['polyunsaturated_fat']);
        finalFoodResults.add(polyUnsaturatedFatsList);
      } else {
        await polyUnsaturatedFatsResult.forEach((value) {
          polyUnsaturatedFatsList.add(value['polyunsaturated_fat']);
        });
        finalFoodResults.add(polyUnsaturatedFatsList);
      }
      if (await monoUnsaturatedFatsResult == null) {
        monoUnsaturatedFatsList.add(null);
        finalFoodResults.add(monoUnsaturatedFatsList);
      } else if (monoUnsaturatedFatsResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        monoUnsaturatedFatsList
            .add(await monoUnsaturatedFatsResult['monounsaturated_fat']);
        finalFoodResults.add(monoUnsaturatedFatsList);
      } else {
        await monoUnsaturatedFatsResult.forEach((value) {
          monoUnsaturatedFatsList.add(value['monounsaturated_fat']);
        });
        finalFoodResults.add(monoUnsaturatedFatsList);
      }
      if (await transFatsResult == null) {
        transFatList.add(null);
        finalFoodResults.add(transFatList);
      } else if (transFatsResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        transFatList.add(await transFatsResult['trans_fat']);
        finalFoodResults.add(transFatList);
      } else {
        await transFatsResult.forEach((value) {
          transFatList.add(value['trans_fat']);
        });
        finalFoodResults.add(transFatList);
      }
      if (await cholesterolResult == null) {
        cholesterolList.add(null);
        finalFoodResults.add(cholesterolList);
      } else if (cholesterolResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        cholesterolList.add(await cholesterolResult['cholesterol']);
        finalFoodResults.add(cholesterolList);
      } else {
        await cholesterolResult.forEach((value) {
          cholesterolList.add(value['cholesterol']);
        });
        finalFoodResults.add(cholesterolList);
      }
      if (await sodiumResult == null) {
        sodiumList.add(null);
        finalFoodResults.add(sodiumList);
      } else if (sodiumResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        sodiumList.add(await sodiumResult['sodium']);
        finalFoodResults.add(sodiumList);
      } else {
        await sodiumResult.forEach((value) {
          sodiumList.add(value['sodium']);
        });
        finalFoodResults.add(sodiumList);
      }
      if (await potassiumResult == null) {
        potassiumList.add(null);
        finalFoodResults.add(potassiumList);
      } else if (potassiumResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        potassiumList.add(await potassiumResult['potassium']);
        finalFoodResults.add(potassiumList);
      } else {
        await potassiumResult.forEach((value) {
          potassiumList.add(value['potassium']);
        });
        finalFoodResults.add(potassiumList);
      }
      if (await fiberResult == null) {
        fiberList.add(null);
        finalFoodResults.add(fiberList);
      } else if (fiberResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        fiberList.add(await fiberResult['fiber']);
        finalFoodResults.add(fiberList);
      } else {
        await fiberResult.forEach((value) {
          fiberList.add(value['fiber']);
        });
        finalFoodResults.add(fiberList);
      }
      if (await sugarsResult == null) {
        sugarsList.add(null);
        finalFoodResults.add(sugarsList);
      } else if (sugarsResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        sugarsList.add(await sugarsResult['sugar']);
        finalFoodResults.add(sugarsList);
      } else {
        await sugarsResult.forEach((value) {
          sugarsList.add(value['sugar']);
        });
        finalFoodResults.add(sugarsList);
      }
      if (await vitaminAResult == null) {
        vitaminAList.add(null);
        finalFoodResults.add(vitaminAList);
      } else if (vitaminAResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        vitaminAList.add(await vitaminAResult['vitamin_a']);
        finalFoodResults.add(vitaminAList);
      } else {
        await vitaminAResult.forEach((value) {
          vitaminAList.add(value['vitamin_a']);
        });
        finalFoodResults.add(vitaminAList);
      }

      if (await vitaminCResult == null) {
        vitaminCResult.add(null);
        finalFoodResults.add(vitaminCList);
      } else if (vitaminCResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        vitaminCList.add(await vitaminCResult['vitamin_c']);
        finalFoodResults.add(vitaminCList);
      } else {
        await vitaminCResult.forEach((value) {
          vitaminCList.add(value['vitamin_c']);
        });
        finalFoodResults.add(vitaminCList);
      }

      if (await calciumResult == null) {
        calciumResult.add(null);
        finalFoodResults.add(calciumResult);
      } else if (calciumResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        calciumList.add(await calciumResult['calcium']);
        finalFoodResults.add(calciumList);
      } else {
        await calciumResult.forEach((value) {
          calciumList.add(value['calcium']);
        });
        finalFoodResults.add(calciumList);
      }

      if (await ironResult == null) {
        ironResult.add(null);
        finalFoodResults.add(ironResult);
      } else if (ironResult.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        ironList.add(await ironResult['iron']);
        finalFoodResults.add(ironList);
      } else {
        await ironResult.forEach((value) {
          ironList.add(value['iron']);
        });
        finalFoodResults.add(ironList);
      }

   

    }

    return finalFoodResults;
  }


}
