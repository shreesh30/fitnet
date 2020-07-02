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
  static List caloriesList=[];
  static List carbsList=[];
  static List fatsList=[];
  static List proteinsList=[];

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
    // print(result);
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
    // finalResults.clear();
    // directionList.clear();
    // ingredientList.clear();
    // ingredientListTile.clear();
    // directionListTile.clear();
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
      // print(result.runtimeType);
      // print(result);
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
    // print(foodNameList);
  }

  Future getFood(foodId) async {
    servingDescriptionList.clear();
    finalFoodResults.clear();
    servingDescriptionDropdownItems.clear();
    // servingDescriptionList.clear();
    // servingDescriptionList.clear();
    // finalFoodResults.clear();
    caloriesList.clear();
    carbsList.clear();
    proteinsList.clear();
    fatsList.clear();

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
    // print(result['food']['servings']['serving']['serving_description']);
    // print(result['food']['servings']['serving'][4]['metric_serving_amount']); // List<dynamic>

    // print(result['food']['servings']['serving']); // List<dynamic>
    // List testList=[];
    // result['food']['servings']['serving'].forEach((foodItems){testList.add(foodItems['measurement_description']);});
    // print(result['food']['servings']['serving'][1]);

    //     List testList = [];
    // result['food']['servings']['serving'].forEach((foodItems) {
    //   testList.add(foodItems['measurement_description']); //[cup (8 fl oz), fl oz, oz, g, ml]
    // });
    //  List testList2 = [];
    // result['food']['servings']['serving'].forEach((foodItems) {
    //   testList2.add(foodItems['serving_description']);//[1 cup (8 fl oz), 1 fl oz, 1 oz, 100 g, 100 ml]
    // });
    //     List testList3 = [];
    // result['food']['servings']['serving'].forEach((foodItems) {
    //   testList3.add(foodItems['metric_serving_unit']);//[g, g, g, g, g]
    // });
    //     List testList4 = [];
    // result['food']['servings']['serving'].forEach((foodItems) {
    //   testList4.add(foodItems['metric_serving_amount']);//[237.000, 29.600, 28.350, 100.000, 100.090]

    // });
    // print(result['food']['servings']['serving'][0]['serving_description']);

    if (result != null) {
      // print(result['food']['servings']['serving'].runtimeType); //List<dynamic>

      // print(result['food']['servings']['serving'][0]['calories']); //List<dynamic>
      // print(result['food']['servings']['serving']['calories']);
            // print(result['food']['servings']['serving']);//_InternalLinkedHashMap<String, dynamic>

      // print(result['food']['servings']['serving']['carbohydrate']);
      // print(result['food']['servings']['serving']['fat']);
      // print(result['food']['servings']['serving']['protein']);

      var servingDescription = await result['food']['servings']['serving'];
      var caloriesResult=await result['food']['servings']['serving'];
      var carbsResult=await result['food']['servings']['serving'];
      var fatsResult=await result['food']['servings']['serving'];
      var proteinsResult=await result['food']['servings']['serving'];

      //1.serving description
      //2.calories
      //3.carbs
      // 4.fat
      // 5.protein

      if (await servingDescription == null) {
        finalFoodResults.add(null);
      } else if (servingDescription.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        // servingDescription['serving_description'].forEach((value){servingDescriptionDropdownItems.add(value)});
        // servingDescriptionList.add(await servingDescription['serving_description']);
        // print(servingDescription);
        servingDescriptionList.add(await servingDescription['serving_description']);
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
                element,
              )));
        });
        finalFoodResults.add(servingDescriptionDropdownItems);
      }
      if(await caloriesResult==null){
        finalFoodResults.add(null);
      }
      else if(caloriesResult.runtimeType.toString()=='_InternalLinkedHashMap<String, dynamic>'){
        caloriesList.add(await caloriesResult['calories']);
          finalFoodResults.add(caloriesList);
      }
      else{
        await caloriesResult.forEach((value){
          caloriesList.add(value['calories']);
        });
        finalFoodResults.add(caloriesList);
      }
      if(await carbsResult==null){
        finalFoodResults.add(null);
      }
      else if(carbsResult.runtimeType.toString()=='_InternalLinkedHashMap<String, dynamic>'){
        carbsList.add(await carbsResult['carbohydrate']);
          finalFoodResults.add(carbsList);
      }
      else{
        await carbsResult.forEach((value){
          carbsList.add(value['carbohydrate']);
        });
        finalFoodResults.add(carbsList);
      }
        if(await fatsResult==null){
        finalFoodResults.add(null);
      }
      else if(fatsResult.runtimeType.toString()=='_InternalLinkedHashMap<String, dynamic>'){
        fatsList.add(await fatsResult['fat']);
          finalFoodResults.add(fatsList);
      }
      else{
        await fatsResult.forEach((value){
          fatsList.add(value['fat']);
        });
        finalFoodResults.add(fatsList);
      }
           if(await proteinsResult==null){
        finalFoodResults.add(null);
      }
      else if(proteinsResult.runtimeType.toString()=='_InternalLinkedHashMap<String, dynamic>'){
        proteinsList.add(await proteinsResult['protein']);
          finalFoodResults.add(proteinsList);
      }
      else{
        await proteinsResult.forEach((value){
          proteinsList.add(value['protein']);
        });
        finalFoodResults.add(proteinsList);
      }
      // print(finalFoodResults[1]);
      // print(testList);
      // print(testList2);
      // print(testList3);
      // print(testList4);
      // print(carbsResult);

    }
    
    return finalFoodResults;
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
//
//void main(List<String> args) {
//  RestClient object = RestClient();
//  //  object.getFood(33691);
//  //    object.getRecipeId('Brown Lentil Dal');
//  // object.recipeList(99);
//  //    object.getRecipeName('Brown Lentil Dal');
//  // object.getRecipeImageUrl('27');
//  //   object.getRecipeNameAndId('chicken');
//  //   object.getRecipeNameAndId('dal');
//  //   object.getRecipeNameAndId('chicken');
////  object.getRecipeInfo('27');
//object.getFoodInfo('dal');
//}
