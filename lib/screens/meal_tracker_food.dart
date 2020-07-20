import 'package:fitnet/models/nutrition_data.dart';

import 'package:fitnet/services/apiGetter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class MealTrackerFood extends StatefulWidget {
  static const String id = 'meal_tracker_food';

  final String foodName;
  final String foodId;

  const MealTrackerFood({Key key, this.foodName, this.foodId})
      : super(key: key);
  @override
  _MealTrackerFoodState createState() => _MealTrackerFoodState();
}

class _MealTrackerFoodState extends State<MealTrackerFood> {
  RestClient object = RestClient();
  Future future;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    future = object.getFood(widget.foodId);
    controller = TextEditingController(text: 1.toString());
    Provider.of<NutritionData>(context, listen: false).name = widget.foodName;
    Provider.of<NutritionData>(context, listen: false).numberOfServings = 1;
    Provider.of<NutritionData>(context, listen: false).servingDescription =
        null;
    Provider.of<NutritionData>(context, listen: false).calories = null;
    Provider.of<NutritionData>(context, listen: false).carbs = null;
    Provider.of<NutritionData>(context, listen: false).fat = null;
    Provider.of<NutritionData>(context, listen: false).protein = null;
    Provider.of<NutritionData>(context, listen: false).saturatedFats = null;
    Provider.of<NutritionData>(context, listen: false).polyUnsaturatedFats =
        null;
    Provider.of<NutritionData>(context, listen: false).monoUnsaturatedFats =
        null;
    Provider.of<NutritionData>(context, listen: false).transFat = null;
    Provider.of<NutritionData>(context, listen: false).cholesterol = null;
    Provider.of<NutritionData>(context, listen: false).sodium = null;
    Provider.of<NutritionData>(context, listen: false).potassium = null;
    Provider.of<NutritionData>(context, listen: false).fiber = null;
    Provider.of<NutritionData>(context, listen: false).sugars = null;
    Provider.of<NutritionData>(context, listen: false).vitaminA = null;
    Provider.of<NutritionData>(context, listen: false).vitaminC = null;
    Provider.of<NutritionData>(context, listen: false).calcium = null;
    Provider.of<NutritionData>(context, listen: false).iron = null;
    Provider.of<NutritionData>(context, listen: false).value = null;
  }

  Widget servingPopUp(BuildContext context) {
  
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        
        height: SizeConfig.heightMultiplier*30,
        child: Padding(padding:SizeConfig.widthMultiplier<8?EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier*4.5,horizontal: SizeConfig.widthMultiplier*7):EdgeInsets.only(top: SizeConfig.heightMultiplier*5,left: SizeConfig.widthMultiplier*5,right: SizeConfig.widthMultiplier*5),child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('How Much?',style: TextStyle(fontFamily: 'Roboto',fontSize: SizeConfig.textMultiplier*3,fontWeight: FontWeight.bold),),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.w300,fontSize: SizeConfig.textMultiplier*2,),
                  initialValue: Provider.of<NutritionData>(context)
                      .numberOfServings
                      .toString(),
                  
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    Provider.of<NutritionData>(context, listen: false)
                        .numberOfServings = double.parse(value);
                   
                  },
                  decoration: InputDecoration(
                    
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 1.5,
                        horizontal: SizeConfig.widthMultiplier * 2),
                    hintStyle:
                        TextStyle(fontSize: SizeConfig.textMultiplier * 2),
                  ),
                ),
              ),
              Text(
                'Serving(s) of',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: SizeConfig.textMultiplier * 2.2,
                    fontWeight: FontWeight.w300,
                    textBaseline: TextBaseline.alphabetic),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.widthMultiplier<8?SizeConfig.heightMultiplier:SizeConfig.heightMultiplier*4,
          ),
          DropdownButton(
            value: Provider.of<NutritionData>(context,listen: false).servingDescription==null?RestClient.servingDescriptionList.length>1?RestClient.servingDescriptionList[0]:Provider.of<NutritionData>(context,listen: false).servingDescription:null,
        
            isExpanded: true,
            items: RestClient.servingDescriptionDropdownItems,
            onChanged: (value) {
              Provider.of<NutritionData>(context, listen: false).value = value;
              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                      .servingDescription = RestClient.servingDescriptionList[0]
                  : Provider.of<NutritionData>(context, listen: false)
                      .servingDescription = value;

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                      .calories = double.parse(RestClient.caloriesList[0])
                  : Provider.of<NutritionData>(context, listen: false)
                          .calories =
                      double.parse(RestClient.caloriesList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false).carbs =
                      double.parse(RestClient.carbsList[0])
                  : Provider.of<NutritionData>(context, listen: false).carbs =
                      double.parse(RestClient.carbsList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false).fat =
                      double.parse(RestClient.fatsList[0])
                  : Provider.of<NutritionData>(context, listen: false).fat =
                      double.parse(RestClient.fatsList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false).protein =
                      double.parse(RestClient.proteinsList[0])
                  : Provider.of<NutritionData>(context, listen: false).protein =
                      double.parse(RestClient.proteinsList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .saturatedFats =
                      double.parse(RestClient.saturatedFatsList[0])
                  : Provider.of<NutritionData>(context, listen: false)
                          .saturatedFats =
                      double.parse(RestClient.saturatedFatsList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .polyUnsaturatedFats =
                      RestClient.polyUnsaturatedFatsList[0] != null
                          ? double.parse(RestClient.polyUnsaturatedFatsList[0])
                          : 0.0
                  : RestClient.polyUnsaturatedFatsList != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .polyUnsaturatedFats =
                          double.parse(RestClient.polyUnsaturatedFatsList[
                              RestClient.servingDescriptionList.indexOf(value)])
                      : Provider.of<NutritionData>(context, listen: false)
                          .polyUnsaturatedFats = 0.0;

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .monoUnsaturatedFats =
                      RestClient.monoUnsaturatedFatsList[0] != null
                          ? double.parse(RestClient.monoUnsaturatedFatsList[0])
                          : 0.0
                  : RestClient.monoUnsaturatedFatsList != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .monoUnsaturatedFats =
                          double.parse(RestClient.monoUnsaturatedFatsList[
                              RestClient.servingDescriptionList.indexOf(value)])
                      : Provider.of<NutritionData>(context, listen: false)
                          .monoUnsaturatedFats = 0.0;

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                      .transFat = RestClient.transFatList[0]!=null?double.parse(RestClient.transFatList[0]):0.0
                  : RestClient.transFatList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .transFat =
                          double.parse(RestClient.transFatList[
                              RestClient.servingDescriptionList.indexOf(value)])
                      : Provider.of<NutritionData>(context, listen: false)
                          .transFat = 0.0;

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                      .cholesterol = double.parse(RestClient.cholesterolList[0])
                  : Provider.of<NutritionData>(context, listen: false)
                          .cholesterol =
                      double.parse(RestClient.cholesterolList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false).sodium =
                      double.parse(RestClient.sodiumList[0])
                  : Provider.of<NutritionData>(context, listen: false).sodium =
                      double.parse(RestClient.sodiumList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .potassium =
                      RestClient.potassiumList[0] != null
                          ? double.parse(RestClient.potassiumList[0])
                          : 0.0
                  : RestClient.potassiumList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .potassium =
                          double.parse(RestClient.potassiumList[
                              RestClient.servingDescriptionList.indexOf(value)])
                      : Provider.of<NutritionData>(context, listen: false)
                          .potassium = 0.0;

              value == null
                  ? Provider.of<NutritionData>(context, listen: false).fiber =
                      double.parse(RestClient.fiberList[0])
                  : Provider.of<NutritionData>(context, listen: false).fiber =
                      double.parse(RestClient.fiberList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false).sugars =
                      double.parse(RestClient.sugarsList[0])
                  : Provider.of<NutritionData>(context, listen: false).sugars =
                      double.parse(RestClient.sugarsList[
                          RestClient.servingDescriptionList.indexOf(value)]);

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .vitaminA =
                      RestClient.vitaminAList[0] != null
                          ? double.parse(RestClient.vitaminAList[0])
                          : 0.0
                  : RestClient.vitaminAList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .vitaminA =
                          double.parse(RestClient.vitaminAList[
                              RestClient.servingDescriptionList.indexOf(value)])
                      : Provider.of<NutritionData>(context, listen: false)
                          .vitaminA = 0.0;

              value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .vitaminC =
                      RestClient.vitaminCList[0] != null
                          ? double.parse(RestClient.vitaminCList[0])
                          : 0.0
                  : RestClient.vitaminCList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .vitaminC =
                          double.parse(RestClient.vitaminCList[
                              RestClient.servingDescriptionList.indexOf(value)])
                      : Provider.of<NutritionData>(context, listen: false)
                          .vitaminC = 0.0;

              value == null
                  ? Provider.of<NutritionData>(context, listen: false).calcium =
                      RestClient.calciumList[0] != null
                          ? double.parse(RestClient.calciumList[0])
                          : 0.0
                  : RestClient.calciumList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .calcium =
                          double.parse(RestClient.calciumList[
                              RestClient.servingDescriptionList.indexOf(value)])
                      : Provider.of<NutritionData>(context, listen: false)
                          .calcium = 0.0;

              value == null
                  ? Provider.of<NutritionData>(context, listen: false).iron =
                      RestClient.ironList[0] != null
                          ? double.parse(RestClient.ironList[0])
                          : 0.0
                  : RestClient.ironList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .iron =
                          double.parse(RestClient.ironList[
                              RestClient.servingDescriptionList.indexOf(value)])
                      : Provider.of<NutritionData>(context, listen: false)
                          .iron = 0.0;
        
            },
          ),
          SizedBox(height: SizeConfig.widthMultiplier<8?0:SizeConfig.heightMultiplier*1.5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(elevation: 5.0,onPressed: () {
                 Provider.of<NutritionData>(context, listen: false)
                .numberOfServings = 1.0;
            Provider.of<NutritionData>(context, listen: false)
                .servingDescription = null;
            Provider.of<NutritionData>(context, listen: false).calories = null;
            Provider.of<NutritionData>(context, listen: false).carbs = null;
            Provider.of<NutritionData>(context, listen: false).fat = null;
            Provider.of<NutritionData>(context, listen: false).protein = null;
            Provider.of<NutritionData>(context, listen: false).saturatedFats =
                null;
            Provider.of<NutritionData>(context, listen: false)
                .polyUnsaturatedFats = null;
            Provider.of<NutritionData>(context, listen: false)
                .monoUnsaturatedFats = null;
            Provider.of<NutritionData>(context, listen: false).transFat = null;
            Provider.of<NutritionData>(context, listen: false).cholesterol =
                null;
            Provider.of<NutritionData>(context, listen: false).sodium = null;
            Provider.of<NutritionData>(context, listen: false).potassium = null;
            Provider.of<NutritionData>(context, listen: false).fiber = null;
            Provider.of<NutritionData>(context, listen: false).sugars = null;
            Provider.of<NutritionData>(context, listen: false).vitaminA = null;
            Provider.of<NutritionData>(context, listen: false).vitaminC = null;
            Provider.of<NutritionData>(context, listen: false).calcium = null;
            Provider.of<NutritionData>(context, listen: false).iron = null;
            Navigator.pop(context);
              },child:Text('Cancel',style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.w400,fontSize: SizeConfig.textMultiplier*2),)),
              MaterialButton(elevation: 5,onPressed: () {
                 Provider.of<NutritionData>(context, listen: false).calories =
                (Provider.of<NutritionData>(context, listen: false).value ==
                        null
                    ? (Provider.of<NutritionData>(context, listen: false)
                            .numberOfServings *
                        double.parse(RestClient.caloriesList[0]))
                    : (Provider.of<NutritionData>(context, listen: false)
                            .numberOfServings *
                        double.parse(RestClient.caloriesList[
                            RestClient.servingDescriptionList.indexOf(
                                Provider.of<NutritionData>(context, listen: false)
                                    .value)])));

            Provider.of<NutritionData>(context,listen: false).carbs= Provider.of<NutritionData>(context,listen: false).value == null
                  ? (Provider.of<NutritionData>(context,listen: false).numberOfServings*
                      double.parse(RestClient.carbsList[0]))
                  : ( Provider.of<NutritionData>(context,listen: false).numberOfServings*
                      double.parse(RestClient.carbsList[
                          RestClient.servingDescriptionList.indexOf( Provider.of<NutritionData>(context,listen: false).value)]));

            Provider.of<NutritionData>(context,listen: false).fat=Provider.of<NutritionData>(context,listen:false).value == null
                  ? Provider.of<NutritionData>(context, listen: false).numberOfServings*
                      double.parse(RestClient.fatsList[0])
                  : Provider.of<NutritionData>(context, listen: false).numberOfServings*
                      double.parse(RestClient.fatsList[
                          RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen:false).value)]);

            Provider.of<NutritionData>(context,listen: false).protein= Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false).numberOfServings*
                      double.parse(RestClient.proteinsList[0])
                  : Provider.of<NutritionData>(context, listen: false).numberOfServings*
                      double.parse(RestClient.proteinsList[
                          RestClient.servingDescriptionList.indexOf( Provider.of<NutritionData>(context,listen: false).value)]);

            Provider.of<NutritionData>(context,listen: false).saturatedFats=  Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .numberOfServings*
                      double.parse(RestClient.saturatedFatsList[0])
                  : Provider.of<NutritionData>(context, listen: false)
                          .numberOfServings*
                      double.parse(RestClient.saturatedFatsList[
                          RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)]);

            Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .polyUnsaturatedFats =
                      RestClient.polyUnsaturatedFatsList[0] != null
                          ? double.parse(RestClient.polyUnsaturatedFatsList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                          : 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : RestClient.polyUnsaturatedFatsList != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .polyUnsaturatedFats =
                          double.parse(RestClient.polyUnsaturatedFatsList[
                              RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])* Provider.of<NutritionData>(context,listen: false).numberOfServings
                      : Provider.of<NutritionData>(context, listen: false)
                          .polyUnsaturatedFats = 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings;

               Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .monoUnsaturatedFats =
                      RestClient.monoUnsaturatedFatsList[0] != null
                          ? double.parse(RestClient.monoUnsaturatedFatsList[0])* Provider.of<NutritionData>(context,listen: false).numberOfServings
                          : 0.0* Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : RestClient.monoUnsaturatedFatsList != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .monoUnsaturatedFats =
                          double.parse(RestClient.monoUnsaturatedFatsList[
                              RestClient.servingDescriptionList.indexOf( Provider.of<NutritionData>(context,listen: false).value)])* Provider.of<NutritionData>(context,listen: false).numberOfServings
                      : Provider.of<NutritionData>(context, listen: false)
                          .monoUnsaturatedFats = 0.0* Provider.of<NutritionData>(context,listen: false).numberOfServings;

            Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                      .transFat =RestClient.transFatList[0]!=null?double.parse(RestClient.transFatList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings:0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : RestClient.transFatList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .transFat =
                          double.parse(RestClient.transFatList[
                              RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                      : Provider.of<NutritionData>(context, listen: false)
                          .transFat = 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings;

             Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                      .cholesterol = double.parse(RestClient.cholesterolList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : Provider.of<NutritionData>(context, listen: false)
                          .cholesterol =
                      double.parse(RestClient.cholesterolList[
                          RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings;

             Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false).sodium =
                      double.parse(RestClient.sodiumList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : Provider.of<NutritionData>(context, listen: false).sodium =
                      double.parse(RestClient.sodiumList[
                          RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings;

            Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .potassium =
                      RestClient.potassiumList[0] != null
                          ? double.parse(RestClient.potassiumList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                          : 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : RestClient.potassiumList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .potassium =
                          double.parse(RestClient.potassiumList[
                              RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                      : Provider.of<NutritionData>(context, listen: false)
                          .potassium = 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings;

             Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false).fiber =
                      double.parse(RestClient.fiberList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : Provider.of<NutritionData>(context, listen: false).fiber =
                      double.parse(RestClient.fiberList[
                          RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings;

            Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false).sugars =
                      double.parse(RestClient.sugarsList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : Provider.of<NutritionData>(context, listen: false).sugars =
                      double.parse(RestClient.sugarsList[
                          RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings;

            Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .vitaminA =
                      RestClient.vitaminAList[0] != null
                          ? double.parse(RestClient.vitaminAList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                          : 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : RestClient.vitaminAList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .vitaminA =
                          double.parse(RestClient.vitaminAList[
                              RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                      : Provider.of<NutritionData>(context, listen: false)
                          .vitaminA = 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings;

              Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false)
                          .vitaminC =
                      RestClient.vitaminCList[0] != null
                          ? double.parse(RestClient.vitaminCList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                          : 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : RestClient.vitaminCList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .vitaminC =
                          double.parse(RestClient.vitaminCList[
                              RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                      : Provider.of<NutritionData>(context, listen: false)
                          .vitaminC = 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings;

            Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false).calcium =
                      RestClient.calciumList[0] != null
                          ? double.parse(RestClient.calciumList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                          : 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : RestClient.calciumList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .calcium =
                          double.parse(RestClient.calciumList[
                              RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                      : Provider.of<NutritionData>(context, listen: false)
                          .calcium = 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings;

            Provider.of<NutritionData>(context,listen: false).value == null
                  ? Provider.of<NutritionData>(context, listen: false).iron =
                      RestClient.ironList[0] != null
                          ? double.parse(RestClient.ironList[0])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                          : 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings
                  : RestClient.ironList[0] != null
                      ? Provider.of<NutritionData>(context, listen: false)
                              .iron =
                          double.parse(RestClient.ironList[
                              RestClient.servingDescriptionList.indexOf(Provider.of<NutritionData>(context,listen: false).value)])*Provider.of<NutritionData>(context,listen: false).numberOfServings
                      : Provider.of<NutritionData>(context, listen: false)
                          .iron = 0.0*Provider.of<NutritionData>(context,listen: false).numberOfServings;

            Navigator.pop(context);
              },child:Text('Save',style: TextStyle(fontFamily: 'Roboto',fontSize: SizeConfig.textMultiplier*2,fontWeight: FontWeight.w400),),)
            ],
          )
        ],
      ), ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    Provider.of<NutritionData>(context).name = widget.foodName;

    return Consumer<NutritionData>(
      builder: (BuildContext context, nutritionData, Widget child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: SizeConfig.heightMultiplier * 3,
                  color: Color(0xFFFD5739),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  nutritionData.mealName = null;
                }),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Add Food',
                style: TextStyle(
                    fontFamily: 'CopperPlate',
                    fontSize: SizeConfig.textMultiplier * 3,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: Color(0xFF0F0F0F),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.check,
                  size: SizeConfig.heightMultiplier * 3,
                  color: Color(0xFFFD5739),
                ),
                onPressed: () {
                  var popCount = 0;
                  if (nutritionData.mealName == 'breakfast') {
                    nutritionData.breakfastFoodName.add(widget.foodName);
                
                    nutritionData.addBreakfast();
                    nutritionData.addBreakfastInfo();
                    nutritionData.finalNutritionData();
                   
                  } else if (nutritionData.mealName == 'morning_snack') {
                    nutritionData.morningSnackFoodName.add(widget.foodName);
                  
                    nutritionData.addMorningSnack();
                    nutritionData.addMorningSnackInfo();
                    nutritionData.finalNutritionData();
                  } else if (nutritionData.mealName == 'lunch') {
                    nutritionData.lunchFoodName.add(widget.foodName);
                   
                    nutritionData.addLunch();
                    nutritionData.addLunchInfo();
                    nutritionData.finalNutritionData();
                  } else if (nutritionData.mealName == 'evening_snack') {
                    nutritionData.eveningSnackFoodName.add(widget.foodName);
                   
                    nutritionData.addEveningSnack();
                    nutritionData.addEveningSnackInfo();
                    nutritionData.finalNutritionData();
                  } else if (nutritionData.mealName == 'dinner') {
                    nutritionData.dinnerFoodName.add(widget.foodName);
                    
                    nutritionData.addDinner();
                    nutritionData.addDinnerInfo();
                    nutritionData.finalNutritionData();
                  }

                  
                  Navigator.popUntil(context, (route) => popCount++ == 2);
                  
                },
              )
            ],
          ),
          body: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.none)
                    return Center(child: new CircularProgressIndicator());
                  else
                   
                    return ListView(
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 6,
                              top: SizeConfig.heightMultiplier * 2),
                          title: Text(
                            widget.foodName,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: SizeConfig.textMultiplier * 2.3,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        ListTile(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => servingPopUp(context),
                            );
                          },
                          contentPadding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 6,
                              right: SizeConfig.widthMultiplier * 6,
                              top: SizeConfig.heightMultiplier < 10
                                  ? 0
                                  : SizeConfig.heightMultiplier),
                          title: Text(
                            'Number of Servings',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                fontSize: SizeConfig.textMultiplier * 2),
                          ),
                          trailing: Text(
                            Provider.of<NutritionData>(context)
                                .numberOfServings
                                .toString(),
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                fontSize: SizeConfig.textMultiplier * 2),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        ListTile(
                          onTap: () {
                            // servingPopUp(context);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => servingPopUp(context),
                            );
                          },
                          contentPadding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 6,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier < 10
                                  ? 0
                                  : SizeConfig.heightMultiplier),
                          title: Text(
                            'Serving Size',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                fontSize: SizeConfig.textMultiplier * 2),
                          ),
                          trailing: Container(
                            alignment: Alignment.centerRight,
                            width: SizeConfig.widthMultiplier * 50,
                            child: RichText(
                              overflow: TextOverflow.clip,
                              text: TextSpan(
                                text: Provider.of<NutritionData>(context,
                                                listen: false)
                                            .servingDescription ==
                                        null
                                    ? RestClient.servingDescriptionList[0]
                                    : Provider.of<NutritionData>(context,
                                            listen: false)
                                        .servingDescription,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier < 10
                                  ? 0
                                  : SizeConfig.heightMultiplier),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                   
                                    snapshot.data[1][0] != null
                                        ? Text(
                                            Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .calories ==
                                                    null
                                                ? RestClient.caloriesList[0]
                                                : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .calories
                                                    .toStringAsFixed(1),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5))
                                        
                                        : Text('-',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5)),
                                    Text('Cal',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                    
                                    snapshot.data[2][0] != null
                                        ? Text(
                                            Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .carbs ==
                                                    null
                                                ? RestClient.carbsList[0] + 'g'
                                                : Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .carbs
                                                        .toStringAsFixed(1) +
                                                    'g',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5))
                                   
                                        : Text('-',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5)),
                                    Text('Carbs',
                                        style: TextStyle(
                                            color: Color(0xFF03DAC5),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                      
                                    snapshot.data[3][0] != null
                                        ? Text(
                                            Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .fat ==
                                                    null
                                                ? RestClient.fatsList[0] + 'g'
                                                : Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .fat
                                                        .toStringAsFixed(1) +
                                                    'g',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5))
                                       
                                        : Text('-',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5)),
                                    Text('Fat',
                                        style: TextStyle(
                                            color: Color(0xFFFAD96B),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                           
                                    snapshot.data[4] != null
                                        ? Text(
                                            Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .protein ==
                                                    null
                                                ? RestClient.proteinsList[0] +
                                                    'g'
                                                : Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .protein
                                                        .toStringAsFixed(1) +
                                                    'g',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5))
                                
                                        : Text('-',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5)),
                                    Text('Protein',
                                        style: TextStyle(
                                            color: Color(0xFFEB1555),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Calories',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                Text(
                                    Provider.of<NutritionData>(context,
                                                    listen: false)
                                                .calories ==
                                            null
                                        ? RestClient.caloriesList[0]
                                        : Provider.of<NutritionData>(context,
                                                listen: false)
                                            .calories
                                            .toStringAsFixed(1),
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Fat',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                Text(
                                    Provider.of<NutritionData>(context,
                                                    listen: false)
                                                .fat ==
                                            null
                                        ? RestClient.fatsList[0] + 'g'
                                        : Provider.of<NutritionData>(context,
                                                    listen: false)
                                                .fat
                                                .toStringAsFixed(1) +
                                            'g',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2))
                               
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Saturated',
                                    style: TextStyle(
                                        color: Color(0xFF6F6F6F),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[5] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context, listen: false)
                                                    .saturatedFats ==
                                                null
                                            ? RestClient.saturatedFatsList[0] != null
                                                ? double.parse(RestClient.saturatedFatsList[0])
                                                        .toStringAsFixed(1) +
                                                    'g'
                                                : '-'
                                            : Provider.of<NutritionData>(context, listen: false)
                                                    .saturatedFats
                                                    .toStringAsFixed(1) +
                                                'g',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                               
                                    : Text('-',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize: SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Polyunsaturated',
                                    style: TextStyle(
                                        color: Color(0xFF6F6F6F),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[6][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context, listen: false)
                                                    .polyUnsaturatedFats ==
                                                null
                                            ? double.parse(RestClient.polyUnsaturatedFatsList[0])
                                                    .toStringAsFixed(1) +
                                                'g'
                                            : Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .polyUnsaturatedFats
                                                    .toStringAsFixed(1) +
                                                'g',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                               
                                    : Text('-',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Monounsaturated',
                                    style: TextStyle(
                                        color: Color(0xFF6F6F6F),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[7][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context, listen: false)
                                                    .monoUnsaturatedFats ==
                                                null
                                            ? double.parse(RestClient.monoUnsaturatedFatsList[0])
                                                    .toStringAsFixed(1) +
                                                'g'
                                            : Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .monoUnsaturatedFats
                                                    .toStringAsFixed(1) +
                                                'g',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                  
                                    : Text('-',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Trans',
                                    style: TextStyle(
                                        color: Color(0xFF6F6F6F),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[8][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context, listen: false)
                                                    .transFat ==
                                                null
                                            ? double.parse(RestClient.transFatList[0])
                                                    .toStringAsFixed(1) +
                                                'g'
                                            : Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .transFat
                                                    .toStringAsFixed(1) +
                                                'g',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                             
                                    : Text('-',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Cholesterol',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[9][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .cholesterol ==
                                                null
                                            ? double.parse(RestClient
                                                        .cholesterolList[0])
                                                    .toStringAsFixed(1) +
                                                'mg'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .cholesterol
                                                    .toStringAsFixed(1) +
                                                'mg',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Sodium',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[10][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .sodium ==
                                                null
                                            ? double.parse(RestClient
                                                        .sodiumList[0])
                                                    .toStringAsFixed(1) +
                                                'mg'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .sodium
                                                    .toStringAsFixed(1) +
                                                'mg',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                    
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Potassium',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[11][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .potassium ==
                                                null
                                            ? double.parse(RestClient
                                                        .potassiumList[0])
                                                    .toStringAsFixed(1) +
                                                'mg'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .potassium
                                                    .toStringAsFixed(1) +
                                                'mg',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Carbohydrates',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[2][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .carbs ==
                                                null
                                            ? RestClient.carbsList[0] + 'g'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .carbs
                                                    .toStringAsFixed(1) +
                                                'g',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Fiber',
                                    style: TextStyle(
                                        color: Color(0xFF6F6F6F),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[12][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .fiber ==
                                                null
                                            ? RestClient.fiberList[0] + 'g'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .fiber
                                                    .toStringAsFixed(1) +
                                                'g',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                
                                    : Text('-',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Sugars',
                                    style: TextStyle(
                                        color: Color(0xFF6F6F6F),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[13][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .sugars ==
                                                null
                                            ? RestClient.sugarsList[0] + 'g'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .sugars
                                                    .toStringAsFixed(1) +
                                                'g',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                    
                                    : Text('-',
                                        style: TextStyle(
                                            color: Color(0xFF6F6F6F),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Protein',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[4][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .protein ==
                                                null
                                            ? RestClient.proteinsList[0] + 'g'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .protein
                                                    .toStringAsFixed(1) +
                                                'g',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Vitamin A',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[14][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .vitaminA ==
                                                null
                                            ? RestClient.vitaminAList[0] + '%'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .vitaminA
                                                    .toStringAsFixed(1) +
                                                '%',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                  
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Vitamin C',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[15][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .vitaminC ==
                                                null
                                            ? RestClient.vitaminCList[0] + '%'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .vitaminC
                                                    .toStringAsFixed(1) +
                                                '%',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                  
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Calcium',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[16][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .calcium ==
                                                null
                                            ? RestClient.calciumList[0] + '%'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .calcium
                                                    .toStringAsFixed(1) +
                                                '%',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                                  
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: SizeConfig.widthMultiplier * 4,
                          endIndent: SizeConfig.widthMultiplier * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 5,
                              right: SizeConfig.widthMultiplier * 5,
                              top: SizeConfig.heightMultiplier * 1.5,
                              bottom: SizeConfig.heightMultiplier * 1.5),
                          child: Card(
                            color: Color(0xFF0F0F0F),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Iron',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                snapshot.data[17][0] != null
                                    ? Text(
                                        Provider.of<NutritionData>(context,
                                                        listen: false)
                                                    .iron ==
                                                null
                                            ? RestClient.ironList[0] + '%'
                                            : Provider.of<NutritionData>(
                                                        context,
                                                        listen: false)
                                                    .iron
                                                    .toStringAsFixed(1) +
                                                '%',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                               
                                    : Text('-',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2))
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
              }
            },
          ),
        );
      },
    );
  }
}
