import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/multimedia/MultimediaPage.dart';
import 'package:virtual_match/src/page/new/NewPage.dart';
import 'package:virtual_match/src/page/notification/NotificationPage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SharedWidget.dart';

class CircularMenu extends StatefulWidget {
  CircularMenu({Key key}) : super(key: key);

  @override
  _CircularMenuState createState() => _CircularMenuState();
}

class _CircularMenuState extends State<CircularMenu> {
  // ignore: unused_field
  File _imageFile;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => FabCircularMenu(
        key: fabKey,
        // Cannot be `Alignment.center`
        alignment: Alignment.bottomRight,
        ringColor: Colors.white.withAlpha(75),
        // ringDiameter: 500.0,
         ringWidth: 120.0,
         fabSize: 50.0,
         fabElevation: 35.0,
         fabColor: AppTheme.themeWhite,
         fabOpenIcon: Icon(Icons.menu, color: AppTheme.themeDefault),
         fabCloseIcon: Icon(Icons.close, color: AppTheme.themeDefault),
        // fabMargin: const EdgeInsets.all(16.0),
         animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInCubic,

        onDisplayChange: (isOpen) {
          _showSnackBar(
              context, "Menú Virtual Match ${isOpen ? "abierto" : "cerrado"}");
        },

        children: <Widget>[
          RawMaterialButton(
            onPressed: () => sharedText(
                'BIENVENIDO A LA COMUNIDAD',
                '*Virtual Match.*\n *Una aplicación de la Comunidad FIFA Bolivia.*\n💬 Con  *Virtual Match podrás.* \n 🔺 Leer Noticias de la Comunidad. \n 🔺 Enterarte de los eventos. \n 🔺Crear tu jugador y equipos. \n🔺Participar en los torneos. \n 🔺 Conocer campeones de torneos e influencers. \n🔺 Mucho mas... \n📲 *Descargar la App en el siguiente enlace:* https://play.google.com/store/apps/details?id=bo.virtual_matchBolivia',
                'text/html'),
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: FaIcon(FontAwesomeIcons.shareAlt,
                color: AppTheme.themeWhite, size: 25.0),
          ),
          RawMaterialButton(
            onPressed: () {
              navegation(context, NotificationPage());
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),

            child: Image.asset(
              'assets/image/mensajeria.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),

            // child: FaIcon(FontAwesomeIcons.questionCircle,
            //     color: AppTheme.themePurple, size: 25.0),
          ),

          RawMaterialButton(
            elevation: 4,
            onPressed: () {
              navegation(context, MultimediaPage());
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              'assets/image/multimedia.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              navegation(context, NewPage());
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              'assets/image/imagen.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _showSnackBar(context, "Cerrar Menu Circular");
              fabKey.currentState.close();
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              'assets/image/cerrar.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
          )
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
      backgroundColor: AppTheme.themePurple,
    ));
  }
}
