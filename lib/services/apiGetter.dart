import 'dart:async';
import 'dart:convert';
import 'package:fitnet/models/search_food_items.dart';

// import 'package:flutter_test_app/error/FatSecretException.dart';
// import 'package:flutter_test_app/model/dayNutrientsEntry.dart';
import 'package:fitnet/services/api.dart';
// import 'package:flutter_test_app/model/foodItem.dart';

class RestClient {
  // if  you don't have one, generate from fatSecret API
  String consumerKey;

  // if  you don't have one, generate from fatSecret API
  String consumerKeySecret;

  // creates a new RestClient instance.
  // try to make singleton too avoid multiple instances
  // make sure to set AppConfig consumer keys and secrets.
  RestClient() {
    this.consumerKey = 'CONSUMER_KEY';
    this.consumerKeySecret = 'CONSUMER_KEY_SECRET';
  }

  /*
   * Sends an API call to "food.search" method on fatSecret APi
   * the method inputs a query string to search in food
   * Return Type [SearchFoodItem]
   * please refer to model package.
   */


  Future<List<SearchFoodItem>> getFoodName(String query) async {
    List<SearchFoodItem> list = [];
    List foodName=[];

    // FatSecretApi be sure that consumer keys are set before you send a call
    FatSecretApi foodSearch = FatSecretApi(
      this.consumerKey,
      this.consumerKeySecret,
      "",
      "",
    );

    var result = await foodSearch
        .request({"search_expression": query, "method": "recipes.search"})
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json["recipes"])
        .then((json) => json["recipe"])
        .catchError((err) {
          print(err);
        });

    // Create a POJO class and parse it
    result.forEach((foodItem) => list.add(SearchFoodItem.fromJson(foodItem)));
    for(int i=0;i<list.length;i++){
      foodName.add(list[i].recipeName);
    }
    print(foodName);
    return list;
  }

  Future getFood(int foodId) async {
    FatSecretApi foodItem = FatSecretApi(
      this.consumerKey,
      this.consumerKeySecret,
      "",
      "",
    );

    var result = await foodItem
        .request({"food_id": foodId.toString(), "method": "food.get"})
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json["food"])
        .catchError((err) {
          print(err);
        });

    print(result);
  }
}

void main(List<String> args) {
  RestClient object = RestClient();
  object.consumerKey = '0f96f7fee7a7414f96287863baebd11f';
  object.consumerKeySecret = '79a934b831e54641801a001d7320c89d';
//  object.getFood(33691);
  object.getFoodName('dal');
}
