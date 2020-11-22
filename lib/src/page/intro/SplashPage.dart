import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:virtual_match/src/page/login/LogOnPage.dart';
import 'package:virtual_match/src/theme/Theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      top: true,
      bottom: true,
      child: SplashScreen(
        backgroundColor: Colors.black, //AppTheme.themeDefault,
        seconds: 4,
        title: new Text(
          'BIENVENIDO A VIRTUAL MATCH',
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        loaderColor: AppTheme.themePurple,

        //styleTextUnderTheLoader: new TextStyle(),
        navigateAfterSeconds: new LogOnPage(),
        photoSize: 150,
        image: Image(
          image: AssetImage('assets/escudo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
