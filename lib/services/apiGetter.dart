import 'dart:async';
import 'dart:convert';
import 'package:fitnet/models/search_food_items.dart';
import 'package:fitnet/services/api.dart';

class RestClient {
  String consumerKey;

  String consumerKeySecret;
  static List recipeName = [];
  static List recipeDescription = [];
  static List list=[];
  static List finalList=[];

  RestClient() {
    this.consumerKey = '0f96f7fee7a7414f96287863baebd11f';
    this.consumerKeySecret = '79a934b831e54641801a001d7320c89d';
  }

  Future<List> getRecipeName(String query) async {
    // List<SearchFoodItem> list = [];
    // List recipeName = [];
    // List recipeDescription = [];

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
      //  result.forEach((foodItem){
      //     // print(foodItem['recipe_name']);
      //   print(foodItem.runtimeType);
      //   //  return list.add(foodItem);
      //   });
      // for (int i = 0; i < list.length; i++) {
      //   recipeName.add(list[i].recipeName);
      // }
      // await result.forEach((foodItem) {
      //  list.add(foodItem['recipe_name']);
      // });


      // await result.forEach((foodItem)=>list.add(foodItem));
      for (int i = 0; i < result.length; i++) {
           list.add(result[i]);
      }

      for(int j=0;j<list.length;j++){
        if(list[j]!=null){
          finalList.add(list[j]['recipe_name']);
        }
      }
    }

    // print(result); 
    // print(result.runtimeType);
    print(finalList);
    return finalList;
  }

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

void main(List<String> args) {
  RestClient object = RestClient();
//  object.getFood(33691);
  object.getRecipeName('dal');
}

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

// mport 'dart:async';
// import 'dart:convert';

// import 'package:flutter_test_app/error/FatSecretException.dart';
// import 'package:flutter_test_app/model/dayNutrientsEntry.dart';
// import 'package:flutter_test_app/network/fatSecretApi.dart';
// import 'package:flutter_test_app/model/foodItem.dart';
// import 'package:flutter_test_app/model/auth/user_fat_secret_auth_model.dart';

// class RestClient {
//   // if  you don't have one, generate from fatSecret API
//   String consumerKey;

//   // if  you don't have one, generate from fatSecret API
//   String consumerKeySecret;

//   // creates a new RestClient instance.
//   // try to make singleton too avoid multiple instances
//   // make sure to set AppConfig consumer keys and secrets.
//   RestClient() {
//     this.consumerKey = 'CONSUMER_KEY';
//     this.consumerKeySecret = 'CONSUMER_KEY_SECRET';
//   }

//   /*
//    * Sends an API call to "food.search" method on fatSecret APi
//    * the method inputs a query string to search in food
//    * Return Type [SearchFoodItem]
//    * please refer to model package.
//    */
//   Future<List<SearchFoodItem>> searchFood(String query) async {
//     List<SearchFoodItem> list = [];

//     // FatSecretApi be sure that consumer keys are set before you send a call
//     FatSecretApi foodSearch = FatSecretApi(
//       this.consumerKey,
//       this.consumerKeySecret,
//       "",
//       "",
//     );

//     var result = await foodSearch
//         .request({"search_expression": query, "method": "foods.search"})
//         .then((res) => res.body)
//         .then(json.decode)
//         .then((json) => json["foods"])
//         .then((json) => json["food"])
//         .catchError((err) {
//           print(err);
//         });

//     // Create a POJO class and parse it
//     result.forEach((foodItem) => list.add(SearchFoodItem.fromJson(foodItem)));
//     return list;
//   }

//   /*
//    * Sends an API call to "profile.create" method on fatSecret APi
//    * the method inputs unique user Id
//    * Return Type [Map]
//    * please refer to fatSecret return types
//    */
//   Future<Map> createProfile(String userId) async {

//     // Be sure that consumer keys are set before you send a call
//     FatSecretApi api = FatSecretApi(this.consumerKey, this.consumerKeySecret, "", "");

//     var response =
//         api.request({"method": "profile.create", "user_id": userId});

//     var jsonBody = await response.then((res) => res.body).then(json.decode);

//     if (jsonBody["error"] != null) {
//       var errorMap = jsonBody["error"];
//       throw FatSecretException(errorMap["code"], errorMap["message"]);
//     }

//     var profile = jsonBody["profile"];
//     return profile;
//   }

//   /*
//    * Sends an API call to "profile.get_auth" method on fatSecret APi
//    * the method inputs unique user Id
//    * Return Type [Map]
//    * please refer to fatSecret return types
//    */
//   Future<Map> getProfileAuth(String userId) async {
//     //var session = await Preferences().getUserSession();
//     var api =
//         new FatSecretApi(this.consumerKey, this.consumerKeySecret, "", "");
//     var jsonBody = await api
//         .request({"method": "profile.get_auth", "user_id": userId})
//         .then((res) => res.body)
//         .then(json.decode);
// //          .then((json) => json["profile"]);
//     if (jsonBody["error"] != null) {
//       var errorMap = jsonBody["error"];
//       throw new FatSecretException(errorMap["code"], errorMap["message"]);
//     }

//     var profile = jsonBody["profile"];
//     return profile;
//   }

//   /*
//    * Sends an API call to "food_entries.get_month" method on fatSecret APi
//    * the method inputs [Date] and [UserFatSecretAuthModel] optional
//    * if you want to access some other user you can set UserFatSecretAuthModel in parameters
//    * Return Type [DayNutrientsEntry]
//    * please refer to model package
//    */
//   Future<List<DayNutrientsEntry>> getMonthFoodEntries(
//       {String date, UserFatSecretAuthModel user}) async {
//     if (user == null) {
//       // set user if you have already stored user in preferences
// //      var user = await Preferences().getUserSession();
//     }

//     List<DayNutrientsEntry> list = [];

//     var api = new FatSecretApi(this.consumerKey, this.consumerKeySecret,
//         user?.authToken, user?.authSecret);
//     Map<String, String> params = {"method": "food_entries.get_month"};

//     if (date != null && date.isNotEmpty) params["date"] = date;

//     try {
//       var r = await api
//           .request(params)
//           .then((res) => res.body)
//           .then(json.decode)
//           .then((json) => json["month"])
//           .then((json) => json["day"]);

//       if (r is List) {
//         r.forEach((foodItem) => list.add(DayNutrientsEntry.fromJson(foodItem)));
//       } else {
//         list.add(DayNutrientsEntry.fromJson(r));
//       }
//     } catch (e) {}
//     return list;
