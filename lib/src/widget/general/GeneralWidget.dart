import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/OpenWebWidget.dart';
import 'package:page_transition/page_transition.dart';

Widget copyRigth() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 5.0),
      divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(VIRTUAL_MATCH, style: kCopyRigthStyle),
          FaIcon(
            //  FontAwesomeIcons.earlybirds,
            FontAwesomeIcons.playstation,
            color: AppTheme.themeDefault,
            size: 18,
          ),
        ],
      ),
    ],
  );
}

Divider divider() {
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
        Color.fromRGBO(113, 113, 113, 1.0),
        Color.fromRGBO(93, 93, 93, 3.0),
        Color.fromRGBO(48, 50, 48, 1.0),
        Color.fromRGBO(22, 23, 22, 1.0),
      ],
    )),
  );
}

BoxDecoration containerFileds() {
  // return boxDecorationList();
  return BoxDecoration(
      color: Colors.white,
      // gradient: boxDecorationList(),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black26,
            blurRadius: 7.0,
            offset: Offset(2.0, 3.0),
            spreadRadius: 4.0)
      ]);
}

BoxDecoration containerImage() {
  return BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black26,
            blurRadius: 7.0,
            offset: Offset(2.0, 3.0),
            spreadRadius: 4.0)
      ]);
}

boxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black,
            blurRadius: 7.0,
            offset: Offset(2.0, 3.0),
            spreadRadius: 4.0)
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

boxDecorationMenu() {
  return BoxDecoration(
    color: AppTheme.themeBlackBlack,
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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ));
    },
    elevation: 2.0,
    child: icon,
    backgroundColor: color,
  );
}

showSnackbar(String message, GlobalKey<ScaffoldState> scaffoldKey) {
  final snackbar = SnackBar(
    content: Text(message),
    duration: Duration(milliseconds: 1500),
  );

  scaffoldKey.currentState.showSnackBar(snackbar);
}
