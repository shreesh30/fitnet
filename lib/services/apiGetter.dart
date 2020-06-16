import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:fitnet/models/search_food_items.dart';
import 'package:fitnet/services/api.dart';

class RestClient {
  String consumerKey;

  String consumerKeySecret;
  static List recipeName = [];
  static List recipeDescription = [];
  static List recipeNamelist = [];
  static List recipeNameFinalList = [];

  RestClient() {
    this.consumerKey = '0f96f7fee7a7414f96287863baebd11f';
    this.consumerKeySecret = '79a934b831e54641801a001d7320c89d';
  }

  Future getRecipeName(String query) async {
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
      result.forEach((element) {
        recipeNamelist.add(element);
      });

      if (recipeNameFinalList.isNotEmpty) {
        recipeNamelist.forEach((element) {
          if (!recipeNameFinalList.contains(element['recipe_name'])) {
            recipeNameFinalList.add(element['recipe_name']);
          }
        });
      } else {
        recipeNamelist.forEach((element) {
          recipeNameFinalList.add(element['recipe_name']);
        });
      }


    

     

      // for (int j = 0; j < recipeNamelist.length; j++) {
      //   if (recipeNamelist[j] != null) {
      //     recipeNameFinalList.add(recipeNamelist[j]['recipe_name']);
      //   }
      // }
    }
  }

  // Future<List> recipeList(int query) async {

  //   FatSecretApi recipeSearch = FatSecretApi(
  //     this.consumerKey,
  //     this.consumerKeySecret,
  //     "",
  //     "",
  //   );

  //   var result = await recipeSearch
  //       .request({"recipe_id": query.toString(), "method": "recipe.get"})
  //       .then((res) => res.body)
  //       .then(json.decode)
  //       .then((json) => json["recipe"])
  //       .then((json) => json["recipe_name"])
  //       .catchError((err) {
  //         print(err);
  //       });

  //   print(result);

  //   return recipeNameFinalList;
  // }

  // Future getFood(int foodId) async {
  //   FatSecretApi foodItem = FatSecretApi(
  //     this.consumerKey,
  //     this.consumerKeySecret,
  //     "",
  //     "",
  //   );

  //   var result = await foodItem
  //       .request({"food_id": foodId.toString(), "method": "food.get"})
  //       .then((res) => res.body)
  //       .then(json.decode)
  //       .then((json) => json["food"])
  //       .catchError((err) {
  //         print(err);
  //       });

  //   print(result);
  // }

}

// void main(List<String> args) {
//   RestClient object = RestClient();
// //  object.getFood(33691);
//   object.getRecipeName('dal');
//   // object.recipeList(99);
//   object.getRecipeName('butter chicken');
//   object.getRecipeName('dal');
//   object.getRecipeName('dal');
//   object.getRecipeName('dal');
//   object.getRecipeName('dal');
//   object.getRecipeName('dal');
//   object.getRecipeName('tikka');

// }

// import 'dart:async';
// import 'dart:convert';
// import 'package:fitnet/models/search_food_items.dart';
// import 'package:fitnet/services/api.dart';

// class RestClient {
//   String consumerKey;

//   String consumerKeySecret;
//   static List recipeName = [];
//   static List recipeDescription = [];
//   static List<SearchFoodItem> list = [];

//   RestClient() {
//     this.consumerKey = '0f96f7fee7a7414f96287863baebd11f';
//     this.consumerKeySecret = '79a934b831e54641801a001d7320c89d';
//   }

//   Future<List<SearchFoodItem>> getRecipeName(String query) async {
//     // List<SearchFoodItem> list = [];
//     // List recipeName = [];
//     // List recipeDescription = [];

//     FatSecretApi foodSearch = FatSecretApi(
//       this.consumerKey,
//       this.consumerKeySecret,
//       "",
//       "",
//     );

//     var result = await foodSearch
//         .request({"search_expression": query, "method": "recipes.search"})
//         .then((res) => res.body)
//         .then(json.decode)
//         .then((json) => json["recipes"])
//         .then((json) => json["recipe"])
//         .catchError((err) {
//           print(err);
//         });

//     // Create a POJO class and parse it
//     result.forEach((foodItem) => list.add(SearchFoodItem.fromJson(foodItem)));

//     // for (int i = 0; i < list.length; i++) {
//     //   recipeName.add(list[i].recipeName);
//     // }

//     // for (int i = 0; i < list.length; i++) {
//     //   recipeName.add(list[i].recipeName);
//     // }

//     // print(recipeName);
//     // print(recipeDescription);
//     // print(result);
//     print(list);
//     return list;
//   }
