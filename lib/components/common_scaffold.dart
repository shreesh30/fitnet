import 'package:flutter/material.dart';
import 'package:fitnet/size_config.dart';
import 'bottom_nav_bar.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold(
      {this.text, this.automaticallyImplyLeading, this.body, this.actions});

  final String text;
  final bool automaticallyImplyLeading;
  final Widget body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: actions,
          centerTitle: true,
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: automaticallyImplyLeading
              ? IconButton(
                  padding:
                      EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: SizeConfig.heightMultiplier * 3,
                    color: Color(0xFFFD5739),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
              : null,
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: 'CopperPlate',
                  fontSize: SizeConfig.textMultiplier * 3,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Color(0xFF0F0F0F),
        ),
        body: body,
        bottomNavigationBar: BottomNavBar());
  }
}
