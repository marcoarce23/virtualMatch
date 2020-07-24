import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/Const.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/core/album/AlbumLoadPage.dart';
import 'package:virtual_match/src/page/core/album/AlbumPage.dart';
import 'package:virtual_match/src/page/core/catalog/CatalogLoadPage.dart';
import 'package:virtual_match/src/page/core/foldable/FoldablePage.dart';
import 'package:virtual_match/src/page/core/product/LoadProductPage.dart';
import 'package:virtual_match/src/page/intro/IntroPage.dart';
import 'package:virtual_match/src/page/login/LogOnPage.dart';
import 'package:virtual_match/src/page/login/LoginPage.dart';
import 'package:virtual_match/src/page/notification/NotificationLocalPage.dart';
import 'package:virtual_match/src/page/organization/OrganizationPage.dart';
import 'package:virtual_match/src/page/people/PlayerPage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SharedWidget.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
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
                  Icon(icon),
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
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  elevation: 60.0,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ImageOvalNetwork(
                        imageNetworkUrl: imgLogo,
                        sizeImage: Size.fromWidth(70)),
                  )),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Marcelo Sanchez', //prefs.nameUser,
                        style: TextStyle(
                            color: AppTheme.themeWhite, fontSize: 18.0),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    AutoSizeText(
                      'marcelo.sanchez@gmail.com', //;prefs.email,
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
        CustomListTile(Icons.notification_important, '   Notificaciones',
            () => navegation(context, NotificationLocalPage())),
      
      CustomListTile(Icons.gamepad, '   Jugador Virtual Match',
            () => navegation(context, PlayerAllPage())),

        CustomListTile(Icons.add_photo_alternate, '    Galería Multimedia',
            () => navegation(context, LoginPage())),
        CustomListTile(Icons.card_giftcard, '   Ultimas Noticias',
            () => navegation(context, AlbumFlowPage())),
     
        CustomListTile(Icons.shop, '   Crear Noticias',
            () => navegation(context, ProductAllPage())),
        CustomListTile(Icons.shop, '   Cargar Multimedia',
            () => navegation(context, ProductAllPage())),
       
        CustomListTile(Icons.supervised_user_circle, '    Sobre Virtual Match',
            () => navegation(context, OrganizationPage())),
        CustomListTile(
            Icons.share,
            '    Comparte la aplicación',
            () => sharedText(
                'Comparte la App - Terrasur',
                '🔺*virtual_match*🔺 \n Un juego de torneos Virtual .\n💬Atención *EL PRIMER JUEGO DE TORNEOS DE BOLIVIA* . \n 📲 Puede descargar la app desde: https://play.google.com/store/apps/details?id=bo.virtual_matchBolivia',
                'text/html')),
        CustomListTile(Icons.settings, '    Configuración',
            () => navegation(context, LoginPage())),
        // CustomListTile(Icons.add_to_home_screen, '   Acerca de la aplicación',
        //     () => navegation(context, IntroPage())),
        CustomListTile(Icons.exit_to_app, '    Cerrar Sesión',
            () => navegation(context, LogOnPage())),
      ],
    ));
  }
}
