import 'dart:async';
import 'dart:convert';
import 'package:fitnet/services/api.dart';

class RestClient {
  String consumerKey;

  String consumerKeySecret;
  static List recipeName = [];
  static List recipeDescription = [];
  static List recipeNameList = [];
  static List recipeNameFinalList = [];
  static List recipeIdList = [];
  static List recipeIdFinalList = [];

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
      // print(recipeNameFinalList);
      // print(recipeIdFinalList);
    }

    // if (result == null) {
    //   return null;
    // } else {
    //   result.forEach((element) {
    //     recipeIdList.add(element);
    //   });

    //   if (recipeIdFinalList.isNotEmpty) {
    //     recipeIdList.forEach((element) {
    //       if (!recipeIdFinalList.contains(element['recipe_id'])) {
    //         recipeIdFinalList.add(element['recipe_id']);
    //       }
    //     });
    //   } else {
    //     recipeIdList.forEach((element) {
    //       recipeIdFinalList.add(element['recipe_id']);
    //     });
    //   }
    // }
  }

  // Future getRecipeId(String query) async {
  //   FatSecretApi recipeSearch = FatSecretApi(
  //     this.consumerKey,
  //     this.consumerKeySecret,
  //     "",
  //     "",
  //   );

  //   var result = await recipeSearch
  //       .request({"search_expression": query, "method": "recipes.search"})
  //       .then((res) => res.body)
  //       .then(json.decode)
  //       .then((json) => json["recipes"])
  //       .then((json) => json["recipe"])
  //       .catchError((err) {
  //         print(err);
  //       });

  //   // Create a POJO class and parse it
  //   if (result == null) {
  //     return null;
  //   } else {
  //     result.forEach((element) {
  //       recipeIdList.add(element);
  //     });

  //     if (recipeIdFinalList.isNotEmpty) {
  //       recipeIdList.forEach((element) {
  //         if (!recipeIdFinalList.contains(element['recipe_id'])) {
  //           recipeIdFinalList.add(element['recipe_id']);
  //         }
  //       });
  //     } else {
  //       recipeIdList.forEach((element) {
  //         recipeIdFinalList.add(element['recipe_id']);
  //       });
  //     }
  //   }
  // }

  Future getRecipeImageUrl(String recipeId) async {
    FatSecretApi foodItem = FatSecretApi(
      this.consumerKey,
      this.consumerKeySecret,
      "",
      "",
    );

    var result = await foodItem
        .request({"recipe_id": recipeId, "method": "recipe.get"})
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json["recipe"])
        .then((json) => json["recipe_images"])
        .catchError((err) {
          print(err);
        });

    if (await result == null ||
        result == [] ||
        result['recipe_image'] == null) {
      return 'https://static.fatsecret.com/static/images/box/recipe_default.jpg';
    } else if (result['recipe_image'].runtimeType.toString() ==
        'List<dynamic>') {
      return await result['recipe_image'][0];
    } else {
      return await result['recipe_image'];
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

// void main(List<String> args) {
//   RestClient object = RestClient();
//   //  object.getFood(33691);
//   //    object.getRecipeId('Brown Lentil Dal');
//   // object.recipeList(99);
//   //    object.getRecipeName('Brown Lentil Dal');
//   object.getRecipeImageUrl('27');
// //   object.getRecipeNameAndId('chicken');
// //   object.getRecipeNameAndId('dal');
// //   object.getRecipeNameAndId('chicken');
// }
