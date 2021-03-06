import 'package:fitnet/services/apiGetter.dart';
import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';


class Recipe extends StatefulWidget {
  Recipe({this.recipeId, this.recipeName});
  static const String id = 'recipe';
  final String recipeName;
  final String recipeId;


  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  RestClient object = RestClient();
  List<ListTile> directions = [];
  Future future;
  @override
  void initState() {
    super.initState();

    future = fetchData();
  }

  Future fetchData() async {
    RestClient.directionList.clear();
    RestClient.finalRecipeResults.clear();
    RestClient.directionListTile.clear();
    RestClient.ingredientList.clear();
    RestClient.ingredientListTile.clear();
    return object.getRecipeInfo(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.recipeName,
            style: TextStyle(
                fontFamily: 'CopperPlate',
                fontSize: SizeConfig.textMultiplier * 3,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color(0xFF0F0F0F),
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
                    snapshot.data[0] == null
                        ? Container()
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4),
                            height: SizeConfig.heightMultiplier * 35,
                            width: SizeConfig.widthMultiplier * 92,
                            child: Image.network(
                              snapshot.data[0],
                              fit: BoxFit.fill,
                            ),
                          ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Recipe Information :',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2.5,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier,
                              ),
                              snapshot.data[1] == null
                                  ? Container()
                                  : Text(
                                      'Cooking Time : ${snapshot.data[1]} mins',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300),
                                    ),
                              snapshot.data[3] == null
                                  ? Container()
                                  : Text(
                                      'Calories : ${snapshot.data[3]} ',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.left,
                                    ),
                              snapshot.data[4] == null
                                  ? Container()
                                  : Text(
                                      'Carbs : ${snapshot.data[4]} g',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.left,
                                    ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.heightMultiplier,
                              ),
                              snapshot.data[5] == null
                                  ? Container()
                                  : Text(
                                      'Protein : ${snapshot.data[5]} g',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.left,
                                    ),
                              snapshot.data[6] == null
                                  ? Container()
                                  : Text(
                                      'Fats : ${snapshot.data[6]} g',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.left,
                                    ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4),
                      child: Text('Ingredients : ',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2.5,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier,
                    ),
                    snapshot.data[7] == null
                        ? Container()
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: RestClient.ingredientListTile,
                            ),
                          ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    snapshot.data[2] != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 4),
                                child: Text('Recipe : ',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 2.5,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier,
                              ),
                            ],
                          )
                        : null,
                    snapshot.data[2] == null || snapshot.data[2] == []
                        ? Container()
         
                        : Column(
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.heightMultiplier,
                              ),
                          
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: RestClient.directionListTile,
                              ),
                            ],
                          )
                  ],
                );
          }
        },
      ),
    );
  }
}
