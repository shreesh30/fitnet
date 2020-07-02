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
                  initialValue: 1.toString(),
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
            hint: RestClient.servingDescriptionDropdownItems[0],
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
          // print(snapshot.data[1]);
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
                          left: SizeConfig.widthMultiplier * 6,
                          right: SizeConfig.widthMultiplier * 6,
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
                                        ? Text(Provider.of<NutritionData>(context, listen: false).calories == null ? (double.parse((snapshot.data[1][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toString() : ((Provider.of<NutritionData>(context, listen: false).calories) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)).toString(),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5))
                                        : Text(
                                            Provider.of<NutritionData>(context, listen: false).calories == null
                                                ? (double.parse((snapshot.data[1][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings))
                                                    .toString()
                                                : ((Provider.of<NutritionData>(context, listen: false).calories) *
                                                        (Provider.of<NutritionData>(context, listen: false)
                                                            .numberOfServings))
                                                    .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5))
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
                                        ? Text(
                                            Provider.of<NutritionData>(context, listen: false)
                                                        .carbs ==
                                                    null
                                                ? ('${double.parse((snapshot.data[2][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g')
                                                : ('${(Provider.of<NutritionData>(context, listen: false).carbs) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.5))
                                        : Text(
                                            Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .carbs ==
                                                    null
                                                ? ('${double.parse((snapshot.data[2][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g')
                                                : ('${(Provider.of<NutritionData>(context, listen: false).carbs) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5))
                                    : Container(),
                                Text('Carbs',
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
                                snapshot.data[3] != null
                                    ? snapshot.data[3].length > 1
                                        ? Text(
                                            Provider.of<NutritionData>(context, listen: false)
                                                        .fat ==
                                                    null
                                                ? ('${double.parse((snapshot.data[3][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g')
                                                : ('${(Provider.of<NutritionData>(context, listen: false).fat) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier *
                                                    2.5))
                                        : Text(
                                            Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .carbs ==
                                                    null
                                                ? ('${double.parse((snapshot.data[3][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g')
                                                : ('${(Provider.of<NutritionData>(context, listen: false).fat) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5))
                                    : Container(),
                                Text('Fat',
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
                                snapshot.data[4] != null
                                    ? snapshot.data[4].length > 1
                                        ? Text(
                                            Provider.of<NutritionData>(context, listen: false)
                                                        .protein ==
                                                    null
                                                ? ('${double.parse((snapshot.data[4][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g')
                                                : ('${(Provider.of<NutritionData>(context, listen: false).protein) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier *
                                                    2.5))
                                        : Text(
                                            Provider.of<NutritionData>(context,
                                                            listen: false)
                                                        .protein ==
                                                    null
                                                ? ('${double.parse((snapshot.data[4][0])) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g')
                                                : ('${(Provider.of<NutritionData>(context, listen: false).protein) * (Provider.of<NutritionData>(context, listen: false).numberOfServings)}g'),
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w300,
                                                fontSize: SizeConfig.textMultiplier * 2.5))
                                    : Container(),
                                Text('Protein',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
          }
        },
      ),
    );
  }
}
