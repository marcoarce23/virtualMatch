import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/formatTourment/FormatTourmentPage.dart';
import 'package:virtual_match/src/page/core/miniTourment/MiniTourmentLoadPage.dart';
import 'package:virtual_match/src/page/core/player/OnceVsOncePage.dart';
import 'package:virtual_match/src/page/core/player/PlayerEditPage.dart';
import 'package:virtual_match/src/page/core/player/PlayerLoadPage.dart';
import 'package:virtual_match/src/page/faq/FaqListPage.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/intro/IntroPage.dart';
import 'package:virtual_match/src/page/login/LogOnPage.dart';
import 'package:virtual_match/src/page/login/LogOutPage.dart';
import 'package:virtual_match/src/page/multimedia/MultimediaLoadPage.dart';
import 'package:virtual_match/src/page/new/NewLoadPage.dart';
import 'package:virtual_match/src/page/notification/NotificationLoadPage.dart';
import 'package:virtual_match/src/page/notification/NotificationPage.dart';
import 'package:virtual_match/src/page/organization/OrganizationPage.dart';
import 'package:virtual_match/src/page/organization/SocialPage.dart';
import 'package:virtual_match/src/page/organization/SorojchiPage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SharedWidget.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';

class CustomListTile extends StatelessWidget {
  final Widget icon;
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
          splashColor: AppTheme.themeWhite,
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
    print('EL IDE PALYER EN EL DRAWER ES: ${prefs.idPlayer}');

    if (prefs.idPlayer == '-1') return drawerAnonimus(context);

    // if (prefs.idPlayer == '1' || prefs.idLogin == '9' /*COAV login*/)
    //   return drawerVirtualMatch(context);

    if (prefs.idPlayer == '0')
      return drawerVirtualMatch(context); //drawerUser(context);
  }

  Drawer drawerAnonimus(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: boxDecorationMenu(context, IMAGE_ORGANIZATION),
          child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/portada2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Material(
                      color: AppTheme.themeWhite,
                      borderRadius: BorderRadius.all(Radius.circular(60.0)),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/icono1.png',
                          //scale: 0.4,
                          width: 75,
                          height: 75,
                        ),

                        //  child: showPictureOval(null, IMAGE_SOROJCHI, 70.0),
                      )),
                  sizedBox(0, 10),
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Visitante FIFERO',
                            style: TextStyle(
                                color: AppTheme.themeWhite, fontSize: 18.0),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        CustomListTile(
            Image.asset(
              'assets/image/control.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '      Notificaciones',
            () => navegation(context, NotificationPage())),
        CustomListTile(
            ImageOvalNetwork(
                imageNetworkUrl: IMAGE_SOROJCHI, sizeImage: Size.fromWidth(30)),
            '      Sorojchi eclub',
            () => navegation(context, SorojchiPage())),
        CustomListTile(
            Image.asset(
              'assets/aus1.jpg',
              //scale: 0.4,
              width: 50,
              height: 60,
            ),
            'DxrAcer',
            () => navegation(
                context,
                ViewPage(
                    title: 'PAGINA OFICIAL DE DxrAcer'.toString(),
                    url: 'https://www.facebook.com/Tecmarkfans'))),
        CustomListTile(
            ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(35)),
            '      Sobre Virtual Match',
            () => navegation(context, OrganizationPage())),
        CustomListTile(
            Image.asset(
              'assets/image/jugador1.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '        Ayuda Social',
            () => navegation(context, SocialPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.shareAlt,
              size: 25,
            ),
            '          Apoya a la comunidad',
            () => sharedText(
                'BIENVENIDO A LA COMUNIDAD',
                '*Virtual Match.*\n *Una aplicación de la Comunidad FIFA Bolivia.*\n💬 Con  *Virtual Match podrás.* \n 🔺 Leer Noticias de la Comunidad. \n 🔺 Enterarte de los eventos. \n 🔺Crear tu jugador y equipos. \n🔺Participar en los torneos. \n 🔺 Conocer campeones de torneos e influencers. \n🔺 Mucho mas... \n📲 *Descargar la App en el siguiente enlace:* https://play.google.com/store/apps/details?id=bo.virtual_matchBolivia',
                'text/html')),
        CustomListTile(
            Image.asset(
              'assets/pregunta1.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       ¿ Alguna duda? Preguntas',
            () => navegation(context, FaqListPage())),
        CustomListTile(
            Image.asset(
              'assets/image/penal.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       Acerca de la APP.',
            () => navegation(context, IntroPage())),
        CustomListTile(
            ImageOvalNetwork(
                imageNetworkUrl: IMAGE_DEFAULT, sizeImage: Size.fromWidth(30)),
            '       Salir de Virtual MAtch',
            () => navegation(context, LogOnPage())),
      ],
    ));
  }

  Drawer drawerUser(BuildContext context) {
    print('EL IDE PALYER EN EL DRAWER ES: ${prefs.idPlayer}');
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: boxDecorationMenu(context, IMAGE_ORGANIZATION),
          child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/portada2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Material(
                      color: AppTheme.themeWhite,
                      borderRadius: BorderRadius.all(Radius.circular(60.0)),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ImageOvalNetwork(
                            imageNetworkUrl: prefs.avatarImage, //IMAGE_LOGO,
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
                          style: TextStyle(
                              color: AppTheme.themeWhite, fontSize: 16.0),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        CustomListTile(
            Image.asset(
              'assets/image/control.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '      Notificaciones',
            () => navegation(context, NotificationPage())),
        CustomListTile(
            ImageOvalNetwork(
                imageNetworkUrl: IMAGE_SOROJCHI, sizeImage: Size.fromWidth(30)),
            '      Sorojchi eclub',
            () => navegation(context, SorojchiPage())),
        CustomListTile(
            Image.asset(
              'assets/aus1.jpg',
              //scale: 0.4,
              width: 47,
              height: 62,
            ),
            'DxrAcer',
            () => navegation(
                context,
                ViewPage(
                    title: 'PAGINA OFICIAL DE DxrAcer'.toString(),
                    url: 'https://www.facebook.com/Tecmarkfans'))),
        CustomListTile(
            Image.asset(
              'assets/image/jugador2.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '     Jugador de la comunidad', () {
          if (prefs.idPlayer != '0')
            navegation(context, PlayerEditPage());
          else
            navegation(context, PlayerLoadPage());
        }),
        CustomListTile(
            Image.asset(
              'assets/image/pelota.png',
              //scale: 0.4,
              width: 28,
              height: 28,
            ),
            '      Crear MiniTorneo',
            () => navegation(context, MiniTourmentAllPage())),
        CustomListTile(
            ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(35)),
            '      Sobre Virtual Match',
            () => navegation(context, OrganizationPage())),
        CustomListTile(
            Image.asset(
              'assets/image/jugador1.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '        Ayuda Social',
            () => navegation(context, SocialPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.shareAlt,
              size: 25,
            ),
            '          Apoya a la comunidad',
            () => sharedText(
                'BIENVENIDO A LA COMUNIDAD',
                '*Virtual Match.*\n *Una aplicación de la Comunidad FIFA Bolivia.*\n💬 Con  *Virtual Match podrás.* \n 🔺 Leer Noticias de la Comunidad. \n 🔺 Enterarte de los eventos. \n 🔺Crear tu jugador y equipos. \n🔺Participar en los torneos. \n 🔺 Conocer campeones de torneos e influencers. \n🔺 Mucho mas... \n📲 *Descargar la App en el siguiente enlace:* https://play.google.com/store/apps/details?id=bo.virtual_matchBolivia',
                'text/html')),
        CustomListTile(
            Image.asset(
              'assets/pregunta1.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       ¿ Alguna duda? Preguntas',
            () => navegation(context, FaqListPage())),
        CustomListTile(
            Image.asset(
              'assets/image/penal.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       Acerca de la APP.',
            () => navegation(context, IntroPage())),
        CustomListTile(
            Image.asset(
              'assets/image/casa.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       Cerrar Sesión',
            () => navegation(context, LogOutPage())),
      ],
    ));
  }

  Drawer drawerVirtualMatch(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: boxDecorationMenu(context, IMAGE_DEFAULT),
          child: Container(
              child: Column(
            children: <Widget>[
              Material(
                  color: AppTheme.themeWhite,
                  borderRadius: BorderRadius.all(Radius.circular(60.0)),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ImageOvalNetwork(
                        imageNetworkUrl: prefs.avatarImage, //IMAGE_LOGO,
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
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
        CustomListTile(
            Image.asset(
              'assets/image/control.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '      Notificaciones',
            () => navegation(context, NotificationPage())),
        CustomListTile(
            ImageOvalNetwork(
                imageNetworkUrl: IMAGE_SOROJCHI, sizeImage: Size.fromWidth(30)),
            '      Sorojchi eclub',
            () => navegation(context, SorojchiPage())),
        CustomListTile(
            Image.asset(
              'assets/aus1.jpg',
              //scale: 0.4,
              width: 50,
              height: 60,
            ),
            'DxrAcer',
            () => navegation(
                context,
                ViewPage(
                    title: 'PAGINA OFICIAL DE DxrAcer'.toString(),
                    url: 'https://www.facebook.com/Tecmarkfans'))),
        CustomListTile(
            Image.asset(
              'assets/image/jugador2.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '   Jugadores de la comunidad',
            () => navegation(context, PlayerLoadPage())),
        CustomListTile(
            Image.asset(
              'assets/image/pelota.png',
              //scale: 0.4,
              width: 28,
              height: 28,
            ),
            '      Crear MiniTorneo',
            () => navegation(context, MiniTourmentAllPage())),
        CustomListTile(
            ImageOvalNetwork(
                imageNetworkUrl: IMAGE_DEFAULT, sizeImage: Size.fromWidth(30)),
            '      Crear Torneo ',
            () => navegation(context, TourmentAllPage())),
        CustomListTile(
            Image.asset(
              'assets/image/mensajeria.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       Crear Notificaciones',
            () => navegation(context, NotificationAllPage())),
        CustomListTile(
            Image.asset(
              'assets/image/noticias.png',
              //scale: 0.4,
              width: 38,
              height: 38,
            ),
            '     Crear Noticias-Evento',
            () => navegation(context, NewAllPage())),
        CustomListTile(
            Image.asset(
              'assets/image/multimeda3.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       Cargar Multimedia',
            () => navegation(context, MultimediaAllPage())),
        CustomListTile(
            ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(35)),
            '      Sobre Virtual Match',
            () => navegation(context, OrganizationPage())),
        CustomListTile(
            Image.asset(
              'assets/image/jugador1.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '        Ayuda Social',
            () => navegation(context, SocialPage())),
        CustomListTile(
            FaIcon(
              FontAwesomeIcons.shareAlt,
              size: 25,
            ),
            '          Apoya a la comunidad',
            () => sharedText(
                'BIENVENIDO A LA COMUNIDAD',
                '*Virtual Match.*\n *Una aplicación de la Comunidad FIFA Bolivia.*\n💬 Con  *Virtual Match podrás.* \n 🔺 Leer Noticias de la Comunidad. \n 🔺 Enterarte de los eventos. \n 🔺Crear tu jugador y equipos. \n🔺Participar en los torneos. \n 🔺 Conocer campeones de torneos e influencers. \n🔺 Mucho mas... \n📲 *Descargar la App en el siguiente enlace:* https://play.google.com/store/apps/details?id=bo.virtual_matchBolivia',
                'text/html')),
        CustomListTile(
            Image.asset(
              'assets/pregunta1.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       ¿ Alguna duda? Preguntas',
            () => navegation(context, FaqListPage())),
        CustomListTile(
            Image.asset(
              'assets/image/penal.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       Acerca de la APP.',
            () => navegation(context, IntroPage())),
        CustomListTile(
            Image.asset(
              'assets/image/casa.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            '       Cerrar Sesión',
            () => navegation(context, LogOutPage())),
      ],
    ));
  }
}
