import 'package:fitnet/services/apiGetter.dart';
import 'package:flutter/material.dart';

class NutritionData extends ChangeNotifier{
  double numberOfServings=1.0;
  double calories;
  double carbs;
  double fat;
  double protein;
  double saturatedFats;
  double polyUnsaturatedFats;
  double monoUnsaturatedFats;
  double transFat;
  double cholesterol;
  var servingDescription;

  // void servingDescChange(servingDescValue){
  //   servingDescription=servingDescValue;
  //   notifyListeners();
  // }

}