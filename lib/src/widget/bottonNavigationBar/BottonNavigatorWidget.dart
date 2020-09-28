import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/miniTourment/ListMiniTournamentPage.dart';
import 'package:virtual_match/src/page/core/player/PlayerPage.dart';
import 'package:virtual_match/src/page/core/player/PlayerWinnePage.dart';
import 'package:virtual_match/src/page/core/tourment/ListTournamentPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';

class BottonNavigation extends StatefulWidget {
  BottonNavigation({Key key}) : super(key: key);

  @override
  _BottonNavigationState createState() => _BottonNavigationState();
}

class _BottonNavigationState extends State<BottonNavigation> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar.badge(
      {3: '', 1: '', 2: ''},

      backgroundColor: AppTheme.themeDefault,
      badgeColor: AppTheme.themePurple,
      style: TabStyle.reactCircle,
      color: AppTheme.themeWhite,
      elevation: 3.0,
      items: [
        TabItem(
            icon: Image.asset(
              'assets/image/mensajeria.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            title: 'Último'),
        TabItem(
            icon: Image.asset(
              'assets/image/trofeo.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            title: 'Ganadores'),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Torneos',
            isIconBlend: false),
        TabItem(
            icon: Image.asset(
              'assets/image/jugador2.png',
              //scale: 0.4,
              width: 28,
              height: 28,
            ),
            title: 'Jugadores'),
        TabItem(
            icon: Image.asset(
              'assets/image/control.png',
              //scale: 0.4,
              width: 28,
              height: 28,
            ),
            title: 'Mi torneo'),
      ],
      initialActiveIndex: 2, //optional, default as 0
      onTap: (value) {
        setState(() {
          if (value == 0) navegation(context, HomePage());
          if (value == 1) navegation(context, PlayerWinnerPage());
          if (value == 2) navegation(context, ListTournamentPage());
          if (value == 3) navegation(context, PlayerPage());
          if (value == 4) navegation(context, ListMiniTournamentPage());
        });
      },
    );
  }
}
