import 'package:fitnet/services/apiGetter.dart';
import 'package:flutter/material.dart';

class NutritionData extends ChangeNotifier {
  double numberOfServings = 1.0;
  String name; //food name
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
  List breakfastFoodName = [];
  List breakfastFoodCalories = [];
  List breakfastFoodProtein = [];
  List breakfastFoodCarbs = [];
  List breakfastFoodFats = [];
  List morningSnackFoodName = [];
  List morningSnackFoodCalories = [];
  List morningSnackFoodProtein = [];
  List morningSnackFoodCarbs = [];
  List morningSnackFoodFats = [];
  List lunchFoodName = [];
  List lunchFoodCalories = [];
  List lunchFoodProtein = [];
  List lunchFoodCarbs = [];
  List lunchFoodFats = [];
  List eveningSnackFoodName = [];
  List eveningSnackFoodCalories = [];
  List eveningSnackFoodProtein = [];
  List eveningSnackFoodCarbs = [];
  List eveningSnackFoodFats = [];
  List dinnerFoodName = [];
  List dinnerFoodCalories = [];
  List dinnerFoodProtein = [];
  List dinnerFoodCarbs = [];
  List dinnerFoodFats = [];
  String mealName;
  var value;
  double totalBreakfastCalories = 0;
  double totalMorningSnackCalories = 0;
  double totalLunchCalories = 0;
  double totalEveningSnackCalories = 0;
  double totalDinnerCalories = 0;
  // double totalCalories = 0.0;
  double totalBreakfastProtein = 0.0;
  double totalMorningSnackProtein = 0.0;
  double totalLunchProtein = 0.0;
  double totalEveningSnackProtein = 0.0;
  double totalDinnerProtein = 0.0;
  double totalBreakfastFat = 0.0;
  double totalMorningSnackFat = 0.0;
  double totalLunchFat = 0.0;
  double totalEveningSnackFat = 0.0;
  double totalDinnerFat = 0.0;
  double totalBreakfastCarb = 0.0;
  double totalMorningSnackCarb = 0.0;
  double totalLunchCarb = 0.0;
  double totalEveningSnackCarb = 0.0;
  double totalDinnerCarb = 0.0;
  double finalCalorieCount=0.0;
  double finalProteinCount=0.0;
  double finalFatsCount=0.0;
  double finalCarbsCount=0.0;
  // double breakfastCal=0.0;
  // List finalCalories = [];
  // List finalCarbs;
  // List finalProteins;
  // List finalFats;

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
  void addBreakfast() {
    calories == null
        ? breakfastFoodCalories.add(double.parse(RestClient.caloriesList[0]))
        : breakfastFoodCalories.add(calories);
    protein == null
        ? breakfastFoodProtein.add(double.parse(RestClient.proteinsList[0]))
        : breakfastFoodProtein.add(protein);
    fat == null
        ? breakfastFoodFats.add(double.parse(RestClient.fatsList[0]))
        : breakfastFoodFats.add(fat);
    carbs == null
        ? breakfastFoodCarbs.add(double.parse(RestClient.carbsList[0]))
        : breakfastFoodCarbs.add(carbs);
    notifyListeners();
  }

  void addMorningSnack() {
    calories == null
        ? morningSnackFoodCalories.add(double.parse(RestClient.caloriesList[0]))
        : morningSnackFoodCalories.add(calories);
    protein == null
        ? morningSnackFoodProtein.add(double.parse(RestClient.proteinsList[0]))
        : morningSnackFoodProtein.add(protein);
    fat == null
        ? morningSnackFoodFats.add(double.parse(RestClient.fatsList[0]))
        : morningSnackFoodFats.add(fat);
    carbs == null
        ? morningSnackFoodCarbs.add(double.parse(RestClient.carbsList[0]))
        : morningSnackFoodCarbs.add(carbs);
    notifyListeners();
  }

  void addLunch() {
    calories == null
        ? lunchFoodCalories.add(double.parse(RestClient.caloriesList[0]))
        : lunchFoodCalories.add(calories);
    protein == null
        ? lunchFoodProtein.add(double.parse(RestClient.proteinsList[0]))
        : lunchFoodProtein.add(protein);
    fat == null
        ? lunchFoodFats.add(double.parse(RestClient.fatsList[0]))
        : lunchFoodFats.add(fat);
    carbs == null
        ? lunchFoodCarbs.add(double.parse(RestClient.carbsList[0]))
        : lunchFoodCarbs.add(carbs);
    notifyListeners();
  }

  void addEveningSnack() {
    calories == null
        ? eveningSnackFoodCalories.add(double.parse(RestClient.caloriesList[0]))
        : eveningSnackFoodCalories.add(calories);
    protein == null
        ? eveningSnackFoodProtein.add(double.parse(RestClient.proteinsList[0]))
        : eveningSnackFoodProtein.add(protein);
    fat == null
        ? eveningSnackFoodFats.add(double.parse(RestClient.fatsList[0]))
        : eveningSnackFoodFats.add(fat);
    carbs == null
        ? eveningSnackFoodCarbs.add(double.parse(RestClient.carbsList[0]))
        : eveningSnackFoodCarbs.add(carbs);
    notifyListeners();
  }

  void addDinner() {
    calories == null
        ? dinnerFoodCalories.add(double.parse(RestClient.caloriesList[0]))
        : dinnerFoodCalories.add(calories);
    protein == null
        ? dinnerFoodProtein.add(double.parse(RestClient.proteinsList[0]))
        : dinnerFoodProtein.add(protein);
    fat == null
        ? dinnerFoodFats.add(double.parse(RestClient.fatsList[0]))
        : dinnerFoodFats.add(fat);
    carbs == null
        ? dinnerFoodCarbs.add(double.parse(RestClient.carbsList[0]))
        : dinnerFoodCarbs.add(carbs);
    notifyListeners();
  }

  void removeBreakfastFood(int i) {
    totalBreakfastCalories = totalBreakfastCalories - breakfastFoodCalories[i];
    totalBreakfastProtein = totalBreakfastProtein - breakfastFoodProtein[i];
    totalBreakfastFat = totalBreakfastFat - breakfastFoodFats[i];
    totalBreakfastCarb = totalBreakfastCarb - breakfastFoodCarbs[i];
    breakfastFoodName.removeAt(i);
    breakfastFoodCalories.removeAt(i);
    breakfastFoodCarbs.removeAt(i);
    breakfastFoodFats.removeAt(i);
    breakfastFoodProtein.removeAt(i);
    // if(totalBreakfastCalories>0 && breakfastFoodCalories.length>0){
    // totalBreakfastCalories=breakfastFoodCalories.length>1?totalBreakfastCalories-breakfastFoodCalories[i-1]:totalBreakfastCalories-breakfastFoodCalories[i];

    // }
    notifyListeners();
  }

  void removeMorningSnackFood(int i) {
    totalMorningSnackCalories=totalMorningSnackCalories-morningSnackFoodCalories[i];
    totalMorningSnackProtein=totalMorningSnackProtein-morningSnackFoodProtein[i];
    totalMorningSnackFat=totalMorningSnackFat-morningSnackFoodFats[i];
    totalMorningSnackCarb=totalMorningSnackCarb-morningSnackFoodCarbs[i];
    morningSnackFoodName.removeAt(i);
    morningSnackFoodCalories.removeAt(i);
    morningSnackFoodCarbs.removeAt(i);
    morningSnackFoodFats.removeAt(i);
    morningSnackFoodProtein.removeAt(i);
    notifyListeners();
  }

  void removeLunchFood(int i) {
    totalLunchCalories=totalLunchCalories-lunchFoodCalories[i];
    totalLunchProtein=totalLunchProtein-lunchFoodProtein[i];
    totalLunchFat=totalLunchFat-lunchFoodFats[i];
    totalLunchCarb=totalLunchCarb-lunchFoodCarbs[i];
    lunchFoodName.removeAt(i);
    lunchFoodCalories.removeAt(i);
    lunchFoodCarbs.removeAt(i);
    lunchFoodFats.removeAt(i);
    lunchFoodProtein.removeAt(i);
    notifyListeners();
  }

  void removeEveningSnackFood(int i) {
    totalEveningSnackCalories=totalEveningSnackCalories-eveningSnackFoodCalories[i];
    totalEveningSnackProtein=totalEveningSnackProtein-eveningSnackFoodProtein[i];
    totalEveningSnackFat=totalEveningSnackFat-eveningSnackFoodFats[i];
    totalEveningSnackCarb=totalEveningSnackCarb-eveningSnackFoodCarbs[i];
    eveningSnackFoodName.removeAt(i);
    eveningSnackFoodCalories.removeAt(i);
    eveningSnackFoodCarbs.removeAt(i);
    eveningSnackFoodFats.removeAt(i);
    eveningSnackFoodProtein.removeAt(i);
    notifyListeners();
  }

  void removeDinnerFood(int i) {
    totalDinnerCalories=totalDinnerCalories-dinnerFoodCalories[i];
    totalDinnerProtein=totalDinnerProtein-dinnerFoodProtein[i];
    totalDinnerFat=totalDinnerFat-dinnerFoodFats[i];
    totalDinnerCarb=totalDinnerCarb-dinnerFoodCarbs[i];
    dinnerFoodName.removeAt(i);
    dinnerFoodCalories.removeAt(i);
    dinnerFoodCarbs.removeAt(i);
    dinnerFoodFats.removeAt(i);
    dinnerFoodProtein.removeAt(i);
    notifyListeners();
  }

  void finalFoodsLists() {
    // print(name);
    // if (mealName == 'breakfast') {
    //   if (breakfastFoodCalories.length != 0) {
    //     breakfastFoodCalories.forEach((calorie) {
    //       finalCalories.add(calorie);
    //     });
    //   }
    // }

    // if (mealName == 'morning_snack') {
    //   if (morningSnackFoodCalories.length != 0) {
    //     morningSnackFoodCalories.forEach((calorie) {
    //       finalCalories.add(calorie);
    //     });
    //   }
    // }

    // if (mealName == 'lunch') {
    //   if (lunchFoodCalories.length != 0) {
    //     lunchFoodCalories.forEach((calorie) {
    //       finalCalories.add(calorie);
    //     });
    //   }
    // }

    // if (mealName == 'evening_snack') {
    //   if (eveningSnackFoodCalories.length != 0) {
    //     eveningSnackFoodCalories.forEach((calorie) {
    //       finalCalories.add(calorie);
    //     });
    //   }
    // }
    // if (mealName == 'dinner') {
    //   if (dinnerFoodCalories.length != 0) {
    //     dinnerFoodCalories.forEach((calorie) {
    //       finalCalories.add(calorie);
    //     });
    //   }
    // }

    // print(breakfastFoodCalories);
    // print(finalCalories);

    // if (mealName == 'breakfast') {
    //   if (breakfastFoodCalories.length != 0) {
    //     breakfastFoodCalories.forEach((element) {
    //       totalBreakfastCalories += element;
    //     });
    //   }
    // }
    // if (mealName == 'morning_snack') {
    //   if (morningSnackFoodCalories.length != 0) {
    //     morningSnackFoodCalories.forEach((element) {
    //       totalMorningSnackCalories += element;
    //     });
    //   }
    // }

    // if (mealName == 'lunch') {
    //   if (lunchFoodCalories.length != 0) {
    //     lunchFoodCalories.forEach((element) {
    //       totalLunchCalories += element;
    //     });
    //   }
    // }
    // if (mealName == 'evening_snack') {
    //   if (eveningSnackFoodCalories.length != 0) {
    //     eveningSnackFoodCalories.forEach((element) {
    //       totalEveningSnackCalories += element;
    //     });
    //   }
    // }

    // if (mealName == 'dinner') {
    //   if (dinnerFoodCalories.length != 0) {
    //     dinnerFoodCalories.forEach((element) {
    //       totalDinnerCalories += element;
    //     });
    //   }
    // }

    // totalBreakfastCalories+=calories;

    // totalCalories = totalBreakfastCalories +
    //     totalDinnerCalories +
    //     totalEveningSnackCalories +
    //     totalLunchCalories +
    //     totalMorningSnackCalories;
    // print(totalCalories);
  }

  void addBreakfastInfo() {
    calories == null
        ? totalBreakfastCalories =
            totalBreakfastCalories + double.parse(RestClient.caloriesList[0])
        : totalBreakfastCalories = totalBreakfastCalories + calories;

    protein == null
        ? totalBreakfastProtein =
            totalBreakfastProtein + double.parse(RestClient.proteinsList[0])
        : totalBreakfastProtein = totalBreakfastProtein + protein;

    fat == null
        ? totalBreakfastFat =
            totalBreakfastFat + double.parse(RestClient.fatsList[0])
        : totalBreakfastFat = totalBreakfastFat + fat;

    carbs == null
        ? totalBreakfastCarb =
            totalBreakfastCarb + double.parse(RestClient.carbsList[0])
        : totalBreakfastCarb = totalBreakfastCarb + carbs;

    // print(totalBreakfastCalories);
    // print(totalBreakfastProtein);
    // print(totalBreakfastFat);
    // print(totalBreakfastCarb);
    notifyListeners();
  }

  void addMorningSnackInfo() {
    calories == null
        ? totalMorningSnackCalories =
            totalMorningSnackCalories + double.parse(RestClient.caloriesList[0])
        : totalMorningSnackCalories = totalMorningSnackCalories + calories;

    protein == null
        ? totalMorningSnackProtein =
            totalMorningSnackProtein + double.parse(RestClient.proteinsList[0])
        : totalMorningSnackProtein = totalMorningSnackProtein + protein;

    fat == null
        ? totalMorningSnackFat =
            totalMorningSnackFat + double.parse(RestClient.fatsList[0])
        : totalMorningSnackFat = totalMorningSnackFat + fat;

    carbs == null
        ? totalMorningSnackCarb =
            totalMorningSnackCarb + double.parse(RestClient.carbsList[0])
        : totalMorningSnackCarb = totalMorningSnackCarb + carbs;

    // print(totalBreakfastCalories);
    // print(totalBreakfastProtein);
    // print(totalBreakfastFat);
    // print(totalBreakfastCarb);
    notifyListeners();
  }

  void addLunchInfo() {
    calories == null
        ? totalLunchCalories =
            totalLunchCalories + double.parse(RestClient.caloriesList[0])
        : totalLunchCalories = totalLunchCalories + calories;

    protein == null
        ? totalLunchProtein =
            totalLunchProtein + double.parse(RestClient.proteinsList[0])
        : totalLunchProtein = totalLunchProtein + protein;

    fat == null
        ? totalLunchFat = totalLunchFat + double.parse(RestClient.fatsList[0])
        : totalLunchFat = totalLunchFat + fat;

    carbs == null
        ? totalLunchCarb =
            totalLunchCarb + double.parse(RestClient.carbsList[0])
        : totalLunchCarb = totalLunchCarb + carbs;

    // print(totalBreakfastCalories);
    // print(totalBreakfastProtein);
    // print(totalBreakfastFat);
    // print(totalBreakfastCarb);
    notifyListeners();
  }

  void addEveningSnackInfo() {
    calories == null
        ? totalEveningSnackCalories =
            totalEveningSnackCalories + double.parse(RestClient.caloriesList[0])
        : totalEveningSnackCalories = totalEveningSnackCalories + calories;

    protein == null
        ? totalEveningSnackProtein =
            totalEveningSnackProtein + double.parse(RestClient.proteinsList[0])
        : totalEveningSnackProtein = totalEveningSnackProtein + protein;

    fat == null
        ? totalEveningSnackFat =
            totalEveningSnackFat + double.parse(RestClient.fatsList[0])
        : totalEveningSnackFat = totalEveningSnackFat + fat;

    carbs == null
        ? totalEveningSnackCarb =
            totalEveningSnackCarb + double.parse(RestClient.carbsList[0])
        : totalEveningSnackCarb = totalEveningSnackCarb + carbs;

    // print(totalBreakfastCalories);
    // print(totalBreakfastProtein);
    // print(totalBreakfastFat);
    // print(totalBreakfastCarb);
    notifyListeners();
  }

  void addDinnerInfo() {
    calories == null
        ? totalDinnerCalories =
            totalDinnerCalories + double.parse(RestClient.caloriesList[0])
        : totalDinnerCalories = totalDinnerCalories + calories;

    protein == null
        ? totalDinnerProtein =
            totalDinnerProtein + double.parse(RestClient.proteinsList[0])
        : totalDinnerProtein = totalDinnerProtein + protein;

    fat == null
        ? totalDinnerFat = totalDinnerFat + double.parse(RestClient.fatsList[0])
        : totalDinnerFat = totalDinnerFat + fat;

    carbs == null
        ? totalDinnerCarb =
            totalDinnerCarb + double.parse(RestClient.carbsList[0])
        : totalDinnerCarb = totalDinnerCarb + carbs;

    // print(totalBreakfastCalories);
    // print(totalBreakfastProtein);
    // print(totalBreakfastFat);
    // print(totalBreakfastCarb);
    notifyListeners();
  }

  void finalNutritionData(){
      finalCalorieCount=totalBreakfastCalories+totalEveningSnackCalories+totalMorningSnackCalories+totalLunchCalories+totalDinnerCalories;
      finalProteinCount=totalBreakfastProtein+totalMorningSnackProtein+totalLunchProtein+totalEveningSnackProtein+totalDinnerProtein;
      finalFatsCount=totalBreakfastFat+totalMorningSnackFat+totalLunchFat+totalEveningSnackFat+totalDinnerFat;
      finalCarbsCount=totalBreakfastCarb+totalMorningSnackCarb+totalLunchCarb+totalEveningSnackCarb+totalDinnerCarb;

      // print(finalCalorieCount);
      // print(finalProteinCount);
      // print(finalFatsCount);
      // print(finalCarbsCount);
  }

  // void foodInfo(){
  //   breakfastCal=breakfastFoodCalories[breakfastFoodName.indexOf(name)];
  //   print(breakfastCal);
  // }
}
