import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/OpenWebWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

Widget showInformationBasic(
    BuildContext context, String title, String subTitle) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.95,
    margin: EdgeInsets.symmetric(vertical: 0.0),
    decoration: boxDecoration(),
    child: Column(
      children: <Widget>[
        gfListTile(
            Column(
              children: [
                sizedBox(0, 10),
                Text(title, style: kSigsTitleStyle),
                sizedBox(0, 4),
              ],
            ),
            Column(
              children: [
                Text(subTitle, style: kSigssTitleStyle),
                sizedBox(0, 8),
              ],
            ),
            null,
            null,
            null, // avatarCircle(IMAGE_LOGO, 35),
            EdgeInsets.all(0.0),
            EdgeInsets.all(0.0)),
      ],
    ),
  );
  //Text(entity.nombreEquipo);
}

Widget showInformationBasicIcon(BuildContext context, String title,
    String subTitle, String icon, double size1) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.95,
    margin: EdgeInsets.symmetric(vertical: 0.0),
    decoration: boxDecoration(),
    child: Column(
      children: <Widget>[
        gfListTile(
            Column(
              children: [
                sizedBox(0, 10),
                Text(title, style: kSigsTitleStyle),
                sizedBox(0, 4),
              ],
            ),
            Column(
              children: [
                Text(subTitle, style: kSigssTitleStyle),
                sizedBox(0, 8),
              ],
            ),
            null,
            null,
            avatarCircleTransparent(icon, size1),
            EdgeInsets.all(0.0),
            EdgeInsets.all(0.0)),
      ],
    ),
  );
  //Text(entity.nombreEquipo);
}

Widget showInformation(BuildContext context, String title, String subTitle,
    String subSubTitle, String titlePage, String url) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.95,
    margin: EdgeInsets.symmetric(vertical: 0.0),
    decoration: boxDecoration(),
    child: Column(
      children: <Widget>[
        gfListTile(
            Text(title, style: TextStyle(color: AppTheme.themeWhite)),
            Text(subTitle, style: TextStyle(color: AppTheme.themeWhite)),
            Row(
              children: <Widget>[
                sizedBox(0, 4),
                Text(
                  subSubTitle,
                  style: TextStyle(
                      color: AppTheme.themeWhite,
                      textBaseline: TextBaseline.ideographic,
                      //   decoration: TextDecoration.underline,
                      fontSize: 15.0),
                ),
              ],
            ),
            null,
            avatarCircleTransparent(IMAGE_LOGOB, 35),
            EdgeInsets.all(0.0),
            EdgeInsets.all(0.0)),
      ],
    ),
  );
  //Text(entity.nombreEquipo);
}

Widget showInformationSinImage(BuildContext context, String title,
    String subTitle, String subSubTitle, String titlePage, String url) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.95,
    margin: EdgeInsets.symmetric(vertical: 0.0),
    decoration: boxDecoration(),
    child: Column(
      children: <Widget>[
        gfListTile(
            Text(title, style: TextStyle(color: AppTheme.themeWhite)),
            Text(subTitle, style: TextStyle(color: AppTheme.themeWhite)),
            Row(
              children: <Widget>[
                sizedBox(0, 4),
                Text(
                  subSubTitle,
                  style: TextStyle(
                      color: AppTheme.themeWhite,
                      textBaseline: TextBaseline.ideographic,
                      //   decoration: TextDecoration.underline,
                      fontSize: 15.0),
                ),
              ],
            ),
            null,
            null, //avatarCircle(IMAGE_LOGOB, 35),
            EdgeInsets.all(0.0),
            EdgeInsets.all(0.0)),
      ],
    ),
  );
  //Text(entity.nombreEquipo);
}

Widget copyRigth() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      sizedBox(0, 5.0),
      divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(VIRTUAL_MATCH,
              style: TextStyle(
                  color: AppTheme.themeWhite)), //style: kCopyRigthStyle),
          avatarCircleTransparent(IMAGE_DEFAULT, 15),
        ],
      ),
    ],
  );
}

Widget copyRigthClear() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      dividerBlack(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(VIRTUAL_MATCH,
              style: TextStyle(fontSize: 12, color: AppTheme.themeDefault)),
          avatarCircleTransparent(IMAGE_DEFAULT, 15),
        ],
      ),
      divider()
    ],
  );
}

Widget copyRigthBlack() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      sizedBox(0, 5.0),
      dividerBlack(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(VIRTUAL_MATCH, style: TextStyle(color: AppTheme.themeDefault)),
          avatarCircleTransparent(IMAGE_DEFAULT, 15),
        ],
      ),
    ],
  );
}

Divider divider() {
  return Divider(
    thickness: 2.0,
    color: AppTheme.themeWhite,
    endIndent: 20.0,
    indent: 20.0,
  );
}

Divider dividerBlack() {
  return Divider(
    thickness: 2.0,
    color: AppTheme.themeDefault,
    endIndent: 20.0,
    indent: 20.0,
  );
}

Divider dividerWidth(double thickness, Color color) {
  return Divider(
    thickness: thickness,
    color: color,
    endIndent: 20.0,
    indent: 20.0,
  );
}

SizedBox sizedBox(double ancho, double alto) {
  return SizedBox(
    width: ancho,
    height: alto,
  );
}

Widget text(String text, Color color, int maxLines, double size) {
  return Text(text,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
      )
      //  strutStyle: StrutStyle.fromTextStyle(textStyle),
      );
}

navegation(BuildContext context, Widget page) {
  Navigator.push(
      context,
      PageTransition(
        curve: Curves.bounceOut,
        type: PageTransitionType.rotate,
        alignment: Alignment.topCenter,
        child: page,
      ));
}

inputDecoration(String hintText, String labelText, FaIcon icon,
    Color hoverColor, Color fillColor, Color focusColor) {
  return InputDecoration(
    focusColor: focusColor,
    hintText: hintText,
    labelText: labelText,
    icon: icon,
    hoverColor: hoverColor,
    fillColor: fillColor,
  );
}

Widget backgroundBasic(BuildContext context) {
//  final size = MediaQuery.of(context).size;

  return Container(
    // height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/portada2.png'),
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          stops: [0.1, 0.4, 0.7, 0.9],
          colors: [
            Color.fromRGBO(113, 113, 113, 1.0),
            Color.fromRGBO(93, 93, 93, 3.0),
            Color.fromRGBO(48, 50, 48, 1.0),
            Color.fromRGBO(22, 23, 22, 1.0),
          ],
        )),
  );
}

Widget backgroundImage(BuildContext context, String imagen) {
  final size = MediaQuery.of(context).size;

  return Container(
    height: size.height * 0.30,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.1, 0.4, 0.7, 0.9],
      colors: [
        Color.fromRGBO(113, 113, 113, 1.0),
        Color.fromRGBO(93, 93, 93, 3.0),
        Color.fromRGBO(48, 50, 48, 1.0),
        Color.fromRGBO(22, 23, 22, 1.0),
      ],
    )),
  );
}

Widget background(BuildContext context, String imagen) {
  final size = MediaQuery.of(context).size;

  return Container(
    height: size.height * 0.30,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.1, 0.4, 0.7, 0.9],
      colors: [
        // Color.fromRGBO(113, 113, 113, 1.0),
        // Color.fromRGBO(93, 93, 93, 3.0),
        // Color.fromRGBO(48, 50, 48, 1.0),
        // Color.fromRGBO(22, 23, 22, 1.0),
        AppTheme.themeDefault, AppTheme.themeDefault, AppTheme.themeDefault,
        AppTheme.themeDefault,
      ],
    )),
  );
}

BoxDecoration containerFileds() {
  // return boxDecorationList();
  return BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('assets/portada1.png'),
        fit: BoxFit.cover,
      ),
      color: Colors.white,
      // gradient: boxDecorationList(),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themePurple,
            blurRadius: 7.0,
            offset: Offset(1.0, 1.0),
            spreadRadius: 1.0)
      ]);
}

BoxDecoration containerImage() {
  return BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('assets/portada1.png'),
        fit: BoxFit.cover,
      ),
      // color: AppTheme.themeWhite,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themePurple,
            blurRadius: 15.0,
            offset: Offset(2.0, 1.0),
            spreadRadius: 2.0)
      ]);
}

BoxDecoration containerImage2() {
  return BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('assets/portada2.png'),
        fit: BoxFit.cover,
      ),
      // color: AppTheme.themeWhite,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themePurple,
            blurRadius: 15.0,
            offset: Offset(2.0, 1.0),
            spreadRadius: 2.0)
      ]);
}

boxDecoration() {
  return BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('assets/portada1.png'),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.themePurple,
            blurRadius: 9.0,
            offset: Offset(1.0, 1.0),
            spreadRadius: 1.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        stops: [0.1, 0.4, 0.7, 0.9],
        colors: [
          // Color.fromRGBO(113, 113, 113, 1.0),
          // Color.fromRGBO(93, 93, 93, 3.0),
          // Color.fromRGBO(48, 50, 48, 1.0),
          // Color.fromRGBO(22, 23, 22, 1.0),

          // Color.fromRGBO(113, 113, 113, 1.0),
          // Color.fromRGBO(93, 93, 93, 3.0),
          // Color.fromRGBO(48, 50, 48, 1.0),
          // Color.fromRGBO(22, 23, 22, 1.0),

          Colors.white, Colors.white, Colors.white, Colors.white,
        ],
      ));
}

boxDecorationMenu(BuildContext context, String imagen) {
  return BoxDecoration(
    image: new DecorationImage(
      image: new AssetImage('assets/portada2.png'),
      fit: BoxFit.cover,
    ),
    color: AppTheme.themeDefault,
  );
  //     gradient: LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomRight,
  //   stops: [0.1, 0.4, 0.7, 0.9],
  //   colors: [
  //     Color.fromRGBO(113, 113, 113, 1.0),
  //     Color.fromRGBO(93, 93, 93, 3.0),
  //     Color.fromRGBO(48, 50, 48, 1.0),
  //     Color.fromRGBO(22, 23, 22, 1.0),
  //   ],
  // ));
}

Widget generaHttpText(String cadena, String text) {
  if (cadena.contains("http") ||
      cadena.contains("https") ||
      cadena.contains("www")) {
    return InkWell(
      child: Text(text),
      onTap: () {
        openWeb(cadena);
      },
    );
  } else {
    return Text(cadena,
        style: kSubTitleCardStyle, overflow: TextOverflow.clip, softWrap: true);
  }
}

Widget generaHttpIcon(
    String cadena, FaIcon icon, int maxLines, double minFontSize) {
  if (cadena.contains("http") ||
      cadena.contains("https") ||
      cadena.contains("www")) {
    return InkWell(
      child: icon,
      onTap: () {
        openWeb(cadena);
      },
    );
  } else {
    return AutoSizeText(cadena,
        style: kSubTitleCardStyle,
        overflow: TextOverflow.clip,
        softWrap: true,
        maxLines: maxLines,
        minFontSize: minFontSize);
  }
}

Widget floatButton(
    Color color, BuildContext context, FaIcon icon, Widget page) {
  return FloatingActionButton(
    onPressed: () {
      navegation(context, page);
    },
    elevation: 2.0,
    child: icon,
    backgroundColor: color,
  );
}

Widget floatButtonImage(
    Color color, BuildContext context, FaIcon icon, Widget page) {
  return FloatingActionButton(
    onPressed: () {
      navegation(context, page);
    },
    elevation: 2.0,
    child: Image.asset(
      'assets/icono3.png',
      height: 50.0,
      fit: BoxFit.fill,
    ),
    backgroundColor: color,
  );
}

Widget floatButtonImageA(
    Color color, BuildContext context, FaIcon icon, Widget page) {
  return FloatingActionButton(
    onPressed: () {
      navegation(context, page);
    },
    elevation: 2.0,
    child: Image.asset(
      'assets/icono3.png',
      height: 50.0,
      fit: BoxFit.fill,
    ),
    backgroundColor: color,
  );
}

showSnackbar(String message, GlobalKey<ScaffoldState> scaffoldKey) {
  final snackbar = SnackBar(
    backgroundColor: AppTheme.themePurple,
    content: Text(message),
    duration: Duration(milliseconds: 2500),
  );

  scaffoldKey.currentState.showSnackBar(snackbar);
}

showSnackbarWithOutKey(String message, BuildContext context) {
  return Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: AppTheme.themePurple,
    content: Row(
      children: [
        FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeDefault),
        Text(message),
      ],
    ),
    duration: Duration(milliseconds: 2500),
  ));
}
