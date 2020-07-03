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
    // TODO: implement initState
    super.initState();
    future = object.getFood(widget.foodId);
    controller = TextEditingController(text: 1.toString());
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
  }

  Widget servingPopUp(BuildContext context) {
    // controller.text=1.toString();
    return AlertDialog(
      scrollable: true,
      title: Text(
        'How Much?',
        style: TextStyle(fontFamily: 'Roboto'),
      ),
      content: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  initialValue: Provider.of<NutritionData>(context)
                      .numberOfServings
                      .toString(),
                  // controller:TextEditingController(text: 'show me'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    Provider.of<NutritionData>(context, listen: false)
                        .numberOfServings = double.parse(value);
                    print(Provider.of<NutritionData>(context, listen: false)
                        .numberOfServings);
                  },
                  decoration: InputDecoration(
                    // hintText: 'Search Recipes',
                    // border: InputBorder.none,
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
            height: SizeConfig.heightMultiplier,
          ),
          DropdownButton(
            // value: RestClient.servingDescriptionList[0],
            // hint: Text(Provider.of<NutritionData>(context).servingDescription==null?RestClient.servingDescriptionDropdownItems:Provider.of<NutritionData>(context).servingDescription),
            hint: Provider.of<NutritionData>(context).servingDescription == null
                ? RestClient.servingDescriptionDropdownItems[0]
                : Text(Provider.of<NutritionData>(context).servingDescription),
            isExpanded: true,
            items: RestClient.servingDescriptionDropdownItems,
            onChanged: (value) {
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
                      .transFat = double.parse(RestClient.transFatList[0])
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
              // print(Provider.of<NutritionData>(context,listen: false).calories);
              // print(value);
              // value != null
              //     ? Provider.of<NutritionData>(context, listen: false)
              //         .servingDescription = value
              //     : Provider.of<NutritionData>(context, listen: false)
              //             .servingDescription =
              //         RestClient.servingDescriptionList[0];

              // Provider.of<NutritionData>(context).calories=value;
              // print(Provider.of<NutritionData>(context, listen: false)
              //     .servingDescription);
            },
          )
        ],
      ),
      // Expanded(
      //   child: DropdownButton(
      //     isExpanded: true,
      //     items: RestClient.servingDescriptionDropdownItems,
      //     onChanged: (value) {},
      //   ),
      // )

      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          elevation: 5.0,
          child: Text('Cancel'),
        ),
        MaterialButton(
          onPressed: () {},
          elevation: 5.0,
          child: Text('Save'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            }),
        // centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            // widget.foodName,
            'Add Food',
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          // print(snapshot.data[6]);
          //  print(RestClient.servingDescriptionList[0]);
          // print(Provider.of<NutritionData>(context).servingDescription);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.none)
                return Center(child: new CircularProgressIndicator());
              else
                // print(snapshot.data[6]);
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
                        // servingPopUp(context);
                        showDialog(
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
                    //  Row(
                    //    children: <Widget>[
                    //      Column(
                    //        children: <Widget>[
                    //          Text(snapshot.data[1][0].toString()),
                    //          Text('Cal')
                    //        ],
                    //      )
                    //    ],
                    //  ),
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
                                // if(snapshot.data[1].length>1){
                                //   Text(snapshot.data[1][].toString()),
                                // Text('Cal')
                                // }
                                snapshot.data[1] != null
                                    ? snapshot.data[1].length > 1
                                        ? Text(
                                            Provider.of<NutritionData>(context, listen: false).calories == null
                                                ? ((double.parse((snapshot.data[1][0])) *
                                                        (Provider.of<NutritionData>(context, listen: false)
                                                            .numberOfServings))
                                                    .toStringAsFixed(1))
                                                : ((Provider.of<NutritionData>(context,
                                                                listen: false)
                                                            .calories) *
                                                        (Provider.of<NutritionData>(
                                                                context,
                                                                listen: false)
                                                            .numberOfServings))
                                                    .toStringAsFixed(1),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5))
                                        : Text(
                                            Provider.of<NutritionData>(context, listen: false).calories == null
                                                ? (double.parse((snapshot.data[1][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1)
                                                // .toString()
                                                : ((Provider.of<NutritionData>(context, listen: false).calories) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1),
                                            style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, fontSize: SizeConfig.textMultiplier * 2.5))
                                    : Container(),
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
                                // if(snapshot.data[1].length>1){
                                //   Text(snapshot.data[1][].toString()),
                                // Text('Cal')
                                // }
                                snapshot.data[2] != null
                                    ? snapshot.data[2].length > 1
                                        ? Text(Provider.of<NutritionData>(context, listen: false).carbs == null ? ((double.parse((snapshot.data[2][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) + 'g') : (((Provider.of<NutritionData>(context, listen: false).carbs) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) + 'g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier *
                                                    2.5))
                                        : Text(
                                            Provider.of<NutritionData>(context, listen: false).carbs == null
                                                ? ((double.parse((snapshot.data[2][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) +
                                                    'g')
                                                : (((Provider.of<NutritionData>(context, listen: false).carbs) *
                                                            (Provider.of<NutritionData>(context, listen: false)
                                                                .numberOfServings))
                                                        .toStringAsFixed(1) +
                                                    'g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5))
                                    : Container(),
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
                                // if(snapshot.data[1].length>1){
                                //   Text(snapshot.data[1][].toString()),
                                // Text('Cal')
                                // }
                                snapshot.data[3] != null
                                    ? snapshot.data[3].length > 1
                                        ? Text(Provider.of<NutritionData>(context, listen: false).fat == null ? ((double.parse((snapshot.data[3][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) + 'g') : (((Provider.of<NutritionData>(context, listen: false).fat) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) + 'g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier *
                                                    2.5))
                                        : Text(
                                            Provider.of<NutritionData>(context, listen: false).fat == null
                                                ? ((double.parse((snapshot.data[3][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) +
                                                    'g')
                                                : (((Provider.of<NutritionData>(context, listen: false).fat) *
                                                            (Provider.of<NutritionData>(context, listen: false)
                                                                .numberOfServings))
                                                        .toStringAsFixed(1) +
                                                    'g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5))
                                    : Container(),
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
                                // if(snapshot.data[1].length>1){
                                //   Text(snapshot.data[1][].toString()),
                                // Text('Cal')
                                // }
                                snapshot.data[4] != null
                                    ? snapshot.data[4].length > 1
                                        ? Text(Provider.of<NutritionData>(context, listen: false).protein == null ? ((double.parse((snapshot.data[4][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) + 'g') : (((Provider.of<NutritionData>(context, listen: false).protein) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) + 'g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier *
                                                    2.5))
                                        : Text(
                                            Provider.of<NutritionData>(context, listen: false).protein == null
                                                ? ((double.parse((snapshot.data[4][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) +
                                                    'g')
                                                : (((Provider.of<NutritionData>(context, listen: false).protein) *
                                                            (Provider.of<NutritionData>(context, listen: false)
                                                                .numberOfServings))
                                                        .toStringAsFixed(1) +
                                                    'g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5))
                                    : Container(),
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
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            Text(
                                Provider.of<NutritionData>(context, listen: false)
                                            .calories ==
                                        null
                                    ? (double.parse((snapshot.data[1][0])) *
                                            (Provider.of<NutritionData>(context,
                                                    listen: false)
                                                .numberOfServings))
                                        .toStringAsFixed(1)
                                    : ((Provider.of<NutritionData>(context,
                                                    listen: false)
                                                .calories) *
                                            (Provider.of<NutritionData>(context,
                                                    listen: false)
                                                .numberOfServings))
                                        .toStringAsFixed(1),
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
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
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[3].length > 1
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false).fat == null
                                        ? ((double.parse((snapshot.data[3][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context, listen: false).fat) *
                                                    (Provider.of<NutritionData>(context, listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2))
                                : Text(
                                    Provider.of<NutritionData>(context, listen: false).fat == null
                                        ? ((double.parse((snapshot.data[3][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) + 'g')
                                        : (((Provider.of<NutritionData>(context, listen: false).fat) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) + 'g'),
                                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, fontSize: SizeConfig.textMultiplier * 2))
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
                                    color:Color(0xFF6F6F6F),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[5] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false).saturatedFats == null
                                        ? ((double.parse((snapshot.data[5][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context, listen: false).saturatedFats) *
                                                    (Provider.of<NutritionData>(context, listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
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
                                    color:Color(0xFF6F6F6F),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[6][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false).polyUnsaturatedFats == null
                                        ? ((double.parse((snapshot.data[6][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context, listen: false)
                                                        .polyUnsaturatedFats) *
                                                    (Provider.of<NutritionData>(context, listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
                                    style: TextStyle(
                                        color:Color(0xFF6F6F6F),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        color:Color(0xFF6F6F6F),
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
                            Text('Monounsaturated',
                                style: TextStyle(
                                    color:Color(0xFF6F6F6F),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[7][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false).polyUnsaturatedFats == null
                                        ? ((double.parse((snapshot.data[7][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context, listen: false)
                                                        .monoUnsaturatedFats) *
                                                    (Provider.of<NutritionData>(context, listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
                                    style: TextStyle(
                                        color:Color(0xFF6F6F6F),
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
                            Text('Trans',
                                style: TextStyle(
                                    color: Color(0xFF6F6F6F),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[8][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false).transFat == null
                                        ? ((double.parse((snapshot.data[8][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context, listen: false).transFat) *
                                                    (Provider.of<NutritionData>(context, listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
                                    style: TextStyle(
                                        color: Color(0xFF595959),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
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
                            Text('Cholesterol',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[9][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .cholesterol ==
                                            null
                                        ? ((double.parse((snapshot.data[9][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'mg')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .cholesterol) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'mg'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
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
                            Text('Sodium',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[10][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .sodium ==
                                            null
                                        ? ((double.parse((snapshot.data[10][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'mg')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .sodium) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'mg'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
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
                            Text('Potassium',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[11][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .potassium ==
                                            null
                                        ? ((double.parse((snapshot.data[11][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'mg')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .potassium) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'mg'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
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
                            Text('Carbohydrates',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[2][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .carbs ==
                                            null
                                        ? ((double.parse((snapshot.data[2][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .carbs) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
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
                            Text('Fiber',
                                style: TextStyle(
                                    color: Color(0xFF6F6F6F),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[12][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false).carbs == null
                                        ? ((double.parse((snapshot.data[12][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context, listen: false).fiber) *
                                                    (Provider.of<NutritionData>(context, listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
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
                            Text('Sugars',
                                style: TextStyle(
                                    color:Color(0xFF6F6F6F),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[13][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false).sugars == null
                                        ? ((double.parse((snapshot.data[13][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context, listen: false).sugars) *
                                                    (Provider.of<NutritionData>(context, listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
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
                            Text('Protein',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[4][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .protein ==
                                            null
                                        ? ((double.parse((snapshot.data[4][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .protein) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            'g'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
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
                            Text('Vitamin A',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[14][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .vitaminA ==
                                            null
                                        ? ((double.parse((snapshot.data[14][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            '%')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .vitaminA) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            '%'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
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
                            Text('Vitamin C',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[15][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .vitaminC ==
                                            null
                                        ? ((double.parse((snapshot.data[15][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            '%')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .vitaminC) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            '%'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
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
                            Text('Calcium',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[16][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .calcium ==
                                            null
                                        ? ((double.parse((snapshot.data[16][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            '%')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .calcium) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            '%'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
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
                            Text('Iron',
                                style: TextStyle(
                                    // color: Colors.grey[400],
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeConfig.textMultiplier * 2)),
                            snapshot.data[17][0] != null
                                ? Text(
                                    Provider.of<NutritionData>(context, listen: false)
                                                .iron ==
                                            null
                                        ? ((double.parse((snapshot.data[17][0])) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            '%')
                                        : (((Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .iron) *
                                                    (Provider.of<NutritionData>(
                                                            context,
                                                            listen: false)
                                                        .numberOfServings))
                                                .toStringAsFixed(1) +
                                            '%'),
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
                                : Text('-',
                                    style: TextStyle(
                                        // color: Colors.grey[400],
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 2))
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
  }
}
