import 'package:fitnet/components/rounded_button.dart';
import 'package:fitnet/models/user_data.dart';
import 'package:fitnet/screens/new_user3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewUser2 extends StatefulWidget {
  static const String id = 'new_user2';
  @override
  _NewUser2State createState() => _NewUser2State();
}

class _NewUser2State extends State<NewUser2> {
  final String heightUrl = '';
  TextEditingController controller =
      TextEditingController(text: 0.0.toStringAsFixed(1));

  Widget userWeightStatus() {
    if (Provider.of<UserData>(
          context,
        ).userAge >=
        18) {
      if (Provider.of<UserData>(
            context,
          ).userBmi <
          16) {
        return Text(
          'Severe Thinness',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        );
      } else if (Provider.of<UserData>(
                context,
              ).userBmi >=
              16 &&
          Provider.of<UserData>(
                context,
              ).userBmi <=
              17) {
        return Text(
          'Moderate Thinness',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        );
      } else if (Provider.of<UserData>(
                context,
              ).userBmi >=
              17 &&
          Provider.of<UserData>(
                context,
              ).userBmi <=
              18.5) {
        return Text(
          'Mild Thinness',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        );
      } else if (Provider.of<UserData>(
                context,
              ).userBmi >=
              18.5 &&
          Provider.of<UserData>(
                context,
              ).userBmi <=
              25) {
        return Text(
          'Normal',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        );
      } else if (Provider.of<UserData>(
                context,
              ).userBmi >=
              25 &&
          Provider.of<UserData>(
                context,
              ).userBmi <=
              30) {
        return Text(
          'Overweight',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        );
      } else if (Provider.of<UserData>(
                context,
              ).userBmi >=
              30 &&
          Provider.of<UserData>(
                context,
              ).userBmi <=
              35) {
        return Text(
          'Obese Class I',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        );
      } else if (Provider.of<UserData>(
                context,
              ).userBmi >=
              35 &&
          Provider.of<UserData>(
                context,
              ).userBmi <=
              40) {
        return Text(
          'Obese Class II',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        );
      } else
        return Text(
          'Obese Class III',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        );
    } else
      return Text(
        '-',
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: SizeConfig.textMultiplier * 2.5,
            fontWeight: FontWeight.bold),
      );
  }

  
  Widget userIdealWeight() {
    if (Provider.of<UserData>(context).userAge > 18) {
      if (Provider.of<UserData>(context).userHeight >= 147 &&
          Provider.of<UserData>(context).userHeight <= 149) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '40-52 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '54-63 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '65-75 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 149 &&
          Provider.of<UserData>(context).userHeight <= 152) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '43-54 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '56-65 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '67-78 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 152 &&
          Provider.of<UserData>(context).userHeight <= 155) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '44-56 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '58-67 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '69-81 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 155 &&
          Provider.of<UserData>(context).userHeight <= 157) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '45-58 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '60-69 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '72-84 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 157 &&
          Provider.of<UserData>(context).userHeight <= 160) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '47-60 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '62-72 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '74-87 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 160 &&
          Provider.of<UserData>(context).userHeight <= 163) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '49-61 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '64-74 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '77-89 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 163 &&
          Provider.of<UserData>(context).userHeight <= 165) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '50-64 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '66-77 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '79-93 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 165 &&
          Provider.of<UserData>(context).userHeight <= 168) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '52-65 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '68-79 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '82-95 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 168 &&
          Provider.of<UserData>(context).userHeight <= 170) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '54-67 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '70-81 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '84-98 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 170 &&
          Provider.of<UserData>(context).userHeight <= 173) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '55-69 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '72-84 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '87-101 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 173 &&
          Provider.of<UserData>(context).userHeight <= 175) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '57-72 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '74-86 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '89-104 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 175 &&
          Provider.of<UserData>(context).userHeight <= 178) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '58-73 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '77-89 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '92-107 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 178 &&
          Provider.of<UserData>(context).userHeight <= 180) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '60-76 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '79-92 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '95-110 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 180 &&
          Provider.of<UserData>(context).userHeight <= 183) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '62-78 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '81-94 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '98-113 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 183 &&
          Provider.of<UserData>(context).userHeight <= 185) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '64-80 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '83-97 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '100-117 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 185 &&
          Provider.of<UserData>(context).userHeight <= 188) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '65-83 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '86-99 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '103-120 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 188 &&
          Provider.of<UserData>(context).userHeight <= 190) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '67-84 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '88-102 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '106-123 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      } else if (Provider.of<UserData>(context).userHeight >= 190) {
        if (Provider.of<UserData>(context).userBmi >= 19 &&
            Provider.of<UserData>(context).userBmi <= 24) {
          return Text(
            '69-87 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 24 &&
            Provider.of<UserData>(context).userBmi <= 29) {
          return Text(
            '91-105 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        } else if (Provider.of<UserData>(context).userBmi >= 29 &&
            Provider.of<UserData>(context).userBmi <= 35) {
          return Text(
            '109-127 kg',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          );
        }
      }
    }
    return Text(
      '-',
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: SizeConfig.textMultiplier * 2.5,
          fontWeight: FontWeight.bold),
    );
  }

  Widget servingPopUp(BuildContext context) {
    return Consumer<UserData>(
      builder: (BuildContext context, UserData userData, Widget child) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: SizeConfig.widthMultiplier < 8
                ? SizeConfig.heightMultiplier >= 8
                    ? SizeConfig.heightMultiplier * 40
                    : SizeConfig.heightMultiplier > 7
                        ? SizeConfig.heightMultiplier * 45
                        : SizeConfig.heightMultiplier * 47
                : SizeConfig.heightMultiplier * 35,
            child: Padding(
              padding: SizeConfig.widthMultiplier < 8
                  ? EdgeInsets.symmetric(
                      vertical: SizeConfig.heightMultiplier * 4.5,
                      horizontal: SizeConfig.widthMultiplier * 7)
                  : EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 5,
                      left: SizeConfig.widthMultiplier * 5,
                      right: SizeConfig.widthMultiplier * 5),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Easy',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 2.3),
                    ),
                    trailing: Text(
                      '0.25 kg per week',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                    onTap: () {
                      userData.weightAlteringIntensityEasy();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.heightMultiplier
                        : SizeConfig.heightMultiplier * 2.5,
                  ),
                  ListTile(
                    title: Text(
                      'Medium',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 2.3),
                    ),
                    trailing: Text(
                      '0.50 kg per weel',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                    onTap: () {
                      userData.weightAlteringIntensityMedium();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.heightMultiplier
                        : SizeConfig.heightMultiplier * 2.5,
                  ),
                  ListTile(
                    title: Text(
                      'Hard',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 2.3),
                    ),
                    trailing: Text(
                      '0.75 kg per week',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                    onTap: () {
                      userData.weightAlteringIntensityHard();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.heightMultiplier
                        : SizeConfig.heightMultiplier * 2.5,
                  ),
                  ListTile(
                    title: Text(
                      'Very Hard',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 2.3),
                    ),
                    trailing: Text(
                      '1.00 kg per week',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                    onTap: () {
                      userData.weightAlteringIntensityVeryHard();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UserData>(context, listen: false).targetWeight = 0;
    Provider.of<UserData>(context, listen: false).weightAlteringSpeed = null;
    Provider.of<UserData>(context, listen: false).goalReachingTime = null;
    Provider.of<UserData>(context, listen: false).userBmr = null;
    Provider.of<UserData>(context, listen: false).userMaintenanceCal = null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (BuildContext context, UserData userData, Widget child) {
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
            title: Text(
              'Weight Summary',
              style: TextStyle(
                  fontFamily: 'CopperPlate',
                  fontSize: SizeConfig.textMultiplier * 3,
                  fontWeight: FontWeight.w400),
            ),
            backgroundColor: Color(0xFF0F0F0F),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 5,
                    horizontal: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.widthMultiplier * 10
                        : SizeConfig.widthMultiplier * 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SvgPicture.asset(
                          'images/tall-2.svg',
                          height: SizeConfig.heightMultiplier * 10,
                        ),
                        Text(
                          'Your BMI: ' + userData.userBmi.toStringAsFixed(1),
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.textMultiplier * 2),
                        ),
                        userWeightStatus()
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'images/weight.svg',
                          height: SizeConfig.heightMultiplier * 10,
                        ),
                        Text(
                          'Ideal weight range',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.textMultiplier * 2),
                        ),
                        userIdealWeight()
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: Color(0xFF8B8A8D)),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Set Target Weight',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: SizeConfig.textMultiplier * 2.25,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.heightMultiplier * 3.5
                        : SizeConfig.heightMultiplier * 4,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier < 8
                            ? SizeConfig.widthMultiplier * 7
                            : SizeConfig.widthMultiplier * 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.minusCircle,
                            color: Color(0xFFFD5739),
                            size: SizeConfig.heightMultiplier * 3,
                          ),
                          onPressed: () {
                            userData.targetWeightDecrement();
                            controller.text =
                                userData.targetWeight.toStringAsFixed(1);
                            // userData.al
                            userData.weightDifference();
                            userData.weightAlteringSpeed = null;
                            userData.goalReachingTime = null;
                          },
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier < 8
                              ? SizeConfig.widthMultiplier * 12
                              : SizeConfig.widthMultiplier * 17,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.textMultiplier * 2.5,
                            ),
                            controller: controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (value) {
                              userData.targetWeight = double.parse(value);
                              userData.weightDifference();
                              userData.weightAlteringSpeed = null;
                              userData.goalReachingTime = null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier,
                        ),
                        Text(
                          'kg',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: SizeConfig.textMultiplier * 2.5,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier < 8
                              ? SizeConfig.widthMultiplier * 5
                              : SizeConfig.widthMultiplier * 10,
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.plusCircle,
                            size: SizeConfig.heightMultiplier * 3,
                            color: Color(0xFFFD5739),
                          ),
                          onPressed: () {
                            userData.targetWeightIncrement();
                            controller.text =
                                userData.targetWeight.toStringAsFixed(1);
                            userData.weightDifference();
                            userData.weightAlteringSpeed = null;
                            userData.goalReachingTime = null;
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  userData.userWeight > userData.targetWeight
                      ? userData.targetWeight == 0
                          ? Text('')
                          : Text(
                              'How quickly do you want to lose ${userData.differenceWeight.toStringAsFixed(1)} kg ?',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                            )
                      : userData.userWeight == userData.targetWeight
                          ? Text(
                              'For how long you want to maintain ?',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                            )
                          : Text(
                              'How quickly do you want to gain ${userData.differenceWeight.toStringAsFixed(1)} kg ?',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontWeight: FontWeight.w300),
                            ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier > 8
                        ? SizeConfig.heightMultiplier * 2
                        : 0,
                  ),
                  userData.userWeight > userData.targetWeight
                      ? userData.targetWeight == 0
                          ? Container(
                              height: SizeConfig.heightMultiplier > 8
                                  ? SizeConfig.heightMultiplier * 12
                                  : SizeConfig.heightMultiplier * 12.5,
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 30,
                                  vertical: SizeConfig.widthMultiplier > 8
                                      ? SizeConfig.heightMultiplier * 0.9
                                      : userData.weightAlteringSpeed == null
                                          ? 0
                                          : SizeConfig.heightMultiplier * 0.5),
                              child: ListTile(
                                title: Text(
                                  userData.weightAlteringSpeed == 0.25
                                      ? 'Easy'
                                      : userData.weightAlteringSpeed == 0.50
                                          ? 'Medium'
                                          : userData.weightAlteringSpeed == 0.75
                                              ? 'Hard'
                                              : userData.weightAlteringSpeed ==
                                                      1.00
                                                  ? 'Very Hard'
                                                  : 'Select',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300,
                                      fontSize: SizeConfig.textMultiplier * 2),
                                ),
                                trailing: Icon(Icons.arrow_drop_down,
                                    color: Color(0xFFFD5739)),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => servingPopUp(context),
                                  );
                                },
                              ),
                            )
                      : userData.userWeight == userData.targetWeight
                          ? Container(
                              height: SizeConfig.heightMultiplier < 8
                                  ? SizeConfig.heightMultiplier * 15
                                  : SizeConfig.widthMultiplier < 8
                                      ? SizeConfig.heightMultiplier * 12
                                      : SizeConfig.heightMultiplier * 10,
                            )
                          : Padding(
                             
                              padding: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 30,
                                  right: SizeConfig.widthMultiplier * 30,
                                  bottom: SizeConfig.heightMultiplier > 8
                                      ? userData.weightAlteringSpeed == null
                                          ? SizeConfig.heightMultiplier * 4.5
                                          : SizeConfig.heightMultiplier * 1
                                      : userData.weightAlteringSpeed == null
                                          ? SizeConfig.heightMultiplier * 6
                                          : SizeConfig.heightMultiplier * 1),
                              child: ListTile(
                                title: Text(
                                    userData.weightAlteringSpeed == 0.25
                                        ? 'Easy'
                                        : userData.weightAlteringSpeed == 0.50
                                            ? 'Medium'
                                            : userData.weightAlteringSpeed ==
                                                    0.75
                                                ? 'Hard'
                                                : userData.weightAlteringSpeed ==
                                                        1.00
                                                    ? 'Very Hard'
                                                    : 'Select',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2)),
                                trailing: Icon(Icons.arrow_drop_down,
                                    color: Color(0xFFFD5739)),
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => servingPopUp(context),
                                  );
                                },
                              ),
                            ),
              
                  SizedBox(
                    height: SizeConfig.heightMultiplier < 8
                        ? SizeConfig.heightMultiplier * 7
                        : SizeConfig.heightMultiplier * 5,
                  ),
                  userData.userWeight > userData.targetWeight
                      ? userData.targetWeight == 0
                          ? Container()
                          : userData.goalReachingTime != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.widthMultiplier * 5),
                                  child: Text(
                                    'You will reach your goal before ' +
                                        userData.goalReachingTime
                                            .toStringAsFixed(1) +
                                        ' months',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            SizeConfig.textMultiplier * 2),
                                  ),
                                )
                              : Container(
                                  height: SizeConfig.heightMultiplier > 8
                                      ? SizeConfig.heightMultiplier * 5
                                      : SizeConfig.heightMultiplier * 8,
                                )
                      : userData.userWeight == userData.targetWeight
                          ? Container()
                          : userData.goalReachingTime != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.widthMultiplier * 5),
                                  child: Text(
                                      'You will reach your goal before ' +
                                          userData.goalReachingTime
                                              .toStringAsFixed(1) +
                                          ' months',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300,
                                          fontSize:
                                              SizeConfig.textMultiplier * 2)),
                                )
                              : Container(),
                  SizedBox(
                    height: SizeConfig.widthMultiplier < 8
                        ? SizeConfig.heightMultiplier > 8
                            ? SizeConfig.heightMultiplier * 10
                            : SizeConfig.heightMultiplier * 4.1
                        : SizeConfig.heightMultiplier * 18,
                  ),
                ],
              ),
              RoundButton(
                title: 'Set My Goal',
                onPressed: () {
                  // print(userData.userHeight);
                  userData.userMaintenanceCalorieCalculator();
                  userData.finalUserMaintenanceCalorieCalculator();
                  Navigator.push(context, CupertinoPageRoute(
                    builder: (context) {
                      return NewUser3();
                    },
                  ));
                },
              )
            ],
          ),
        );
      },
    );
  }
}
