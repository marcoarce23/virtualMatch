import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  static const Color themeColorRojo = Color.fromRGBO(255, 76, 61, 1); //ff4c3d
  static const Color themeColorCeleste =
      Color.fromRGBO(5, 147, 255, 1); //0593FF
  static const Color themeColorAzul = Color.fromRGBO(18, 64, 120, 1); //124078
  static const Color themeColorNaranja =
      Color.fromRGBO(255, 93, 19, 1); //ff5d12
  static const Color themeColorVerde =
      Color.fromRGBO(100, 179, 116, 1); //64B374
  static const Color themeWhite = Colors.white;
  static const Color themeBlackBlack = Color.fromRGBO(28, 27, 27, 1);
  static const Color themeVino =
      Color.fromRGBO(41, 128, 185, 1.0); //84, 153, 199,1.0);
  static const Color themeDefault = Colors.orange; //84, 153, 199,1.0);
  static const Color themeOrange = Colors.orange;
  static const Color themeGrey = Colors.grey;
  static const Color themeBlackGrey = Colors.black87;
  static const TextStyle themeTitulo = TextStyle(
      fontSize: 15,
      color: AppTheme.themeColorAzul,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic);

  /// begin institution

  static const Color backGroundInstitutionPrimary = Colors.orangeAccent;
  static const Color backGroundInstitutionSecundary = Colors.white;
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 32.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
  );
}
