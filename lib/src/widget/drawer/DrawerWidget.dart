import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentLoadPage.dart';
import 'package:virtual_match/src/page/core/player/PlayerLoadPage.dart';
import 'package:virtual_match/src/page/core/tourment/TourmentLoadPage.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/intro/IntroPage.dart';
import 'package:virtual_match/src/page/login/LogOnPage.dart';
import 'package:virtual_match/src/page/multimedia/MultimediaLoadPage.dart';
import 'package:virtual_match/src/page/new/NewLoadPage.dart';
import 'package:virtual_match/src/page/notification/NotificationLoadPage.dart';
import 'package:virtual_match/src/page/notification/NotificationPage.dart';
import 'package:virtual_match/src/page/organization/OrganizationPage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SharedWidget.dart';
import 'package:virtual_match/src/widget/image/ImageWidget.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';

class CustomListTile extends StatelessWidget {
  final FaIcon icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: InkWell(
          splashColor: Colors.orange,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  icon,
                  Text(
                    text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ]),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final prefs = new Preferense();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: boxDecorationMenu(),
          child: Container(
              child: Column(
            children: <Widget>[
              Material(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(60.0)),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ImageOvalNetwork(
                        imageNetworkUrl: IMAGE_SOROJCHI,
                        sizeImage: Size.fromWidth(70)),

                    //  child: showPictureOval(null, IMAGE_SOROJCHI, 70.0),
                  )),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        prefs.nameUser,
                        style: TextStyle(
                            color: AppTheme.themeWhite, fontSize: 18.0),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    AutoSizeText(
                      prefs.email,
                      style:
                          TextStyle(color: AppTheme.themeWhite, fontSize: 16.0),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.bell,
              size: 25,
            ),
            '   Notificaciones',
            () => navegation(context, NotificationPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.facebook,
              size: 25,
            ),
            '   Visita Sorojchi eclub',
            () => navegation(
                context,
                ViewPage(
                    title: 'Visita Sorojchi eclub'.toString(),
                    url: 'https://www.facebook.com/SorojchieClub/'))),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.userFriends,
              size: 25,
            ),
            '   Jugador Virtual Match',
            () => navegation(context, PlayerAllPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.gamepad,
              size: 25,
            ),
            '    Crea tu equipo',
            () => navegation(context, EquipmentAllPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.playstation,
              size: 25,
            ),
            '   Crea tu torneo',
            () => navegation(context, TourmentAllPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.listAlt,
              size: 25,
            ),
            '   Crear Notificaciones',
            () => navegation(context, NotificationAllPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.edit,
              size: 25,
            ),
            '   Crear Noticias-Evento',
            () => navegation(context, NewAllPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.images,
              size: 25,
            ),
            '   Cargar Multimedia',
            () => navegation(context, MultimediaAllPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.futbol,
              size: 25,
            ),
            '    Sobre Virtual Match',
            () => navegation(context, OrganizationPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.shareAlt,
              size: 25,
            ),
            '    Comparte la aplicación',
            () => sharedText(
                'BIENVENIDO A LA COMUNIDAD',
                '*Virtual Match - Sorojchi eclub.*\n *Una aplicación de la Comunidad FIFA Bolivia.*\n💬 Con  *Virtual Match - Sorojchi eclub podrás.* \n 🔺 Leer Noticias de la Comunidad. \n 🔺 Enterarte de los eventos. \n 🔺Crear tu jugador y equipos. \n🔺Participar en los torneos. \n 🔺 Conocer campeones de torneos e influencers. 🔺 Mucho mas... \n📲 *Descargar la App en el siguiente enlace:* https://play.google.com/store/apps/details?id=bo.virtual_matchBolivia',
                'text/html')),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.questionCircle,
              size: 25,
            ),
            '    Acerca de la APP.',
            () => navegation(context, IntroPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.home,
              size: 25,
            ),
            '    Cerrar Sesión',
            () => navegation(context, LogOnPage())),
      ],
    ));
  }
}
