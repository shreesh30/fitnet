import 'package:fitnet/screens/new_user.dart';
import 'package:flutter/material.dart';


enum Gender {
  male,
  female,
}
class UserData extends ChangeNotifier{
  int userNumber;
  int userAge;
  Gender selectedGender;
  double userWeight;
  double userHeight;

  void changeGenderToMale(){
    selectedGender=Gender.male;
    notifyListeners();
  }

  void changeGenderToFemale(){
    selectedGender=Gender.female;
    notifyListeners();
  }
}