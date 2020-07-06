import 'package:fitnet/services/apiGetter.dart';
import 'package:flutter/material.dart';

class NutritionData extends ChangeNotifier{
  double numberOfServings=1.0;
  String name;
  double calories;
  double carbs;
  double fat;
  double protein;
  double saturatedFats;
  double polyUnsaturatedFats;
  double monoUnsaturatedFats;
  double transFat;
  double cholesterol;
  double sodium;
  double potassium;
  double fiber;
  double sugars;
  double vitaminA;
  double vitaminC;
  double calcium;
  double iron;
  List foodName=[];
  List foodCalories=[];
  List foodProtein=[];
  List foodCarbs=[];
  List foodFats=[];
  var value;

  var servingDescription;


  // void servingDescChange(servingDescValue){
  //   servingDescription=servingDescValue;
  //   notifyListeners();
  // }

  // void updateNutritionData(){
  //   foodName.add(name);
  //   if(calories==null){
  //     foodCalories.add(RestClient.caloriesList[0]);
  //   }
  //   else{
  //     foodCalories.add(calories);
  //   }

  //   print(foodName);
  //   print(foodCalories);
  //   notifyListeners();
  // }

  // void caloriesUpdate(value){
  //     value == null
  //                 ? calories = double.parse(RestClient.caloriesList[0])*numberOfServings
  //                 :calories =
  //                     double.parse(RestClient.caloriesList[
  //                         RestClient.servingDescriptionList.indexOf(value)])*numberOfServings;

    
  // }
}