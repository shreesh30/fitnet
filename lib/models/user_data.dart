
import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
}

class UserData extends ChangeNotifier {
  String userName;
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
  double differenceWeight ;
  double weightAlteringSpeed=0;
  double goalReachingTime=0;
  double userBmr;
  double userMaintenanceCal;
  double finalUserMaintenanceCal;
  String userProfileEditingPage;

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
  void weightDifference() {
    if (targetWeight == 0) {
      targetWeight = 0;
    }
    if (targetWeight > userWeight) {
      differenceWeight = targetWeight - userWeight;
    } else if (targetWeight < userWeight) {
      differenceWeight = userWeight - targetWeight;
    } else if (targetWeight == userWeight) {
      differenceWeight = userWeight - targetWeight;
    }

    notifyListeners();
  }

  void weightAlteringIntensityEasy() {
    weightAlteringSpeed = 0.25;
    timeToReachGoal();
    notifyListeners();
  }

  void weightAlteringIntensityMedium() {
    weightAlteringSpeed = 0.50;
    timeToReachGoal();
    notifyListeners();
  }

  void weightAlteringIntensityHard() {
    weightAlteringSpeed = 0.75;
    timeToReachGoal();
    notifyListeners();
  }

  void weightAlteringIntensityVeryHard() {
    weightAlteringSpeed = 1.00;
    timeToReachGoal();
    notifyListeners();
  }

  void timeToReachGoal() {
    goalReachingTime = (differenceWeight / weightAlteringSpeed) / 4.348125;
    // print(goalReachingTime);
    notifyListeners();
  }

  void userMaintenanceCalorieCalculator() {
    if (userGender == 'male') {
      userBmr = 10 * userWeight + 6.25 * userHeight - 5 * userAge + 5;
      // userMaintenanceCal=
      if (userActivity == 'Sedentary') {
        userMaintenanceCal = userBmr * 1.4;
      } else if (userActivity == 'Lightly Active') {
        userMaintenanceCal = userBmr * 1.7;
      } else if (userActivity == 'Moderately Active') {
        userMaintenanceCal = userBmr * 1.9;
      } else if (userActivity == 'Very Active') {
        userMaintenanceCal = userBmr * 2.1;
      }
    } else if (userGender == 'female') {
      userBmr = 10 * userWeight + 6.25 * userHeight - 5 * userAge - 161;
      if (userActivity == 'Sedentary') {
        userMaintenanceCal = userBmr * 1.4;
      } else if (userActivity == 'Lightly Active') {
        userMaintenanceCal = userBmr * 1.7;
      } else if (userActivity == 'Moderately Active') {
        userMaintenanceCal = userBmr * 1.9;
      } else if (userActivity == 'Very Active') {
        userMaintenanceCal = userBmr * 2.1;
      }
    }
    notifyListeners();
  }

  void finalUserMaintenanceCalorieCalculator(){
    if(userWeight>targetWeight){
      if(weightAlteringSpeed==0.25){
        finalUserMaintenanceCal=userMaintenanceCal*0.85;
      }
      else if(weightAlteringSpeed==0.50){
        finalUserMaintenanceCal=userMaintenanceCal*0.80;
      }
      else if(weightAlteringSpeed==0.75){
        finalUserMaintenanceCal=userMaintenanceCal*0.75;

      }
      else if(weightAlteringSpeed==1.00){
        finalUserMaintenanceCal=userMaintenanceCal*0.70;
      }
    }
    else if(userWeight<targetWeight){
      if(weightAlteringSpeed==0.25){
        finalUserMaintenanceCal=userMaintenanceCal+(userMaintenanceCal*0.10);
      }
      else if(weightAlteringSpeed==0.50){
        finalUserMaintenanceCal=userMaintenanceCal+(userMaintenanceCal*0.15);
      }
      else if(weightAlteringSpeed==0.75){
        finalUserMaintenanceCal=userMaintenanceCal+(userMaintenanceCal*0.20);
      }
      else if(weightAlteringSpeed==1.00){
        finalUserMaintenanceCal=userMaintenanceCal+(userMaintenanceCal*0.25);
      }
    }
    else if(targetWeight.toStringAsFixed(0)==userWeight.toStringAsFixed(0)){
      finalUserMaintenanceCal=userMaintenanceCal;
    }
    notifyListeners();
  }
}
