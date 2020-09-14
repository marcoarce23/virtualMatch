import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/player/PlayerLoadPage.dart';
import 'package:virtual_match/src/page/core/player/PlayerWinnePage.dart';
import 'package:virtual_match/src/page/core/tourment/ListTournamentPage.dart';
import 'package:virtual_match/src/page/new/NewListPage.dart';
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
      elevation: 3.0,
      items: [
        TabItem(
            icon: Image.asset(
              'assets/image/mensajeria.png',
              //scale: 0.4,
              width: 30,
              height: 30,
            ),
            title: 'Noticias'),
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
            title: 'Jugador'),
        TabItem(
            icon: Image.asset(
              'assets/image/control.png',
              //scale: 0.4,
              width: 28,
              height: 28,
            ),
            title: '1 Vs.1'),
      ],
      initialActiveIndex: 2, //optional, default as 0
      onTap: (value) {
        setState(() {
          if (value == 0) navegation(context, NewListPage());
          if (value == 1) navegation(context, PlayerWinnerPage());
          if (value == 2) navegation(context, ListTournamentPage());
          if (value == 3) navegation(context, PlayerLoadPage());
          if (value == 4) navegation(context, PlayerLoadPage());
        });
      },
    );
  }
}
