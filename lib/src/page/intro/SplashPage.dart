import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtual_match/src/page/login/LoginPage.dart';
import 'package:splashscreen/splashscreen.dart';

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
        backgroundColor: Colors.white, //AppTheme.themeDefault,
        seconds: 4,
        navigateAfterSeconds: new LoginPage(),
        photoSize: 200,
        image: Image(
          image: AssetImage('assets/icon.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
