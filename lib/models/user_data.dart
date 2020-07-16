import 'package:fitnet/screens/new_user.dart';
import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
}

class UserData extends ChangeNotifier {
  int userNumber;
  int userAge;
  Gender selectedGender;
  double userWeight;
  double userHeight;
  String userActivity;
  String userGender;
  double userBmi;
  double calculateHeingtHelper;
  double targetWeight = 0;
  double differenceWeight=0;

  void changeGenderToMale() {
    selectedGender = Gender.male;
    if (selectedGender == Gender.male) {
      userGender = 'male';
    } else {
      userGender = 'female';
    }
    notifyListeners();
  }

  void changeGenderToFemale() {
    selectedGender = Gender.female;
    if (selectedGender == Gender.female) {
      userGender = 'female';
    } else {
      userGender = 'male';
    }
    notifyListeners();
  }

  void changeUserActivityTo1() {
    userActivity = 'Sedentary';
    notifyListeners();
  }

  void changeUserActivityTo2() {
    userActivity = 'Lightly Active';
    notifyListeners();
  }

  void changeUserActivityTo3() {
    userActivity = 'Moderately Active';
    notifyListeners();
  }

  void changeUserActivityTo4() {
    userActivity = 'Very Active';
    notifyListeners();
  }

  void calculateBMI() {
    calculateHeingtHelper = userHeight / 100;
    userBmi = (userWeight / (calculateHeingtHelper * calculateHeingtHelper));
    notifyListeners();
  }

  void targetWeightIncrement() {
    targetWeight++;
    notifyListeners();
  }

  void targetWeightDecrement() {
    if (targetWeight > 0) {
      targetWeight--;
      notifyListeners();
    }
  }

  // Widget weightAlteringQuestion() {
  //   if (targetWeight == 0) {
  //     return Text('');
  //   } else if (targetWeight > userWeight) {
  //     return Text('How quickly do you want to gain ' +
  //         (targetWeight - userWeight).toStringAsFixed(1) +
  //         ' kg');
  //   }
  //   // else if(Provider.of<UserData>(context).targetWeight==Provider.of<UserData>(context).userWeight){
  //   //   return
  //   // }
  //   return Text('How quickly do you want to lose ' +
  //       (userWeight - targetWeight).toStringAsFixed(1) +
  //       ' kg');

  // }
  void weightDifference(){
    if(targetWeight==0){
      targetWeight=0;
    }
    if(targetWeight>userWeight){
      differenceWeight=targetWeight-userWeight;
    }
    else if(targetWeight<userWeight){
      differenceWeight=userWeight-targetWeight;
    }
    else if(targetWeight==userWeight){
      differenceWeight=userWeight-targetWeight;
    }

    notifyListeners();
  }
}
