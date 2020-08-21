import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/tourment/ListTournamentPage.dart';
import 'package:virtual_match/src/page/faq/FaqListPage.dart';
import 'package:virtual_match/src/page/new/NewListPage.dart';
import 'package:virtual_match/src/page/new/NewLoadPage.dart';
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
      {3: '200+', 1:'10+', 2: '3+'},

      backgroundColor: AppTheme.themeDefault,
      badgeColor: AppTheme.themePurple,
      style: TabStyle.reactCircle,
      elevation: 3.0,
      items: [
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Noticias'),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Eventos'),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Torneos',
            isIconBlend: false),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: '1 Vs.1'),
        TabItem(
            icon: ImageOvalNetwork(
                imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
            title: 'Clubes Pro'),
      ],
      initialActiveIndex: 2, //optional, default as 0
      onTap: (value) {
        setState(() {
          if (value == 0) navegation(context, NewListPage());
          if (value == 1) navegation(context, NewLoadPage());
          if (value == 2) navegation(context, ListTournamentPage());
          if (value == 3) navegation(context, NewLoadPage());
          if (value == 4) navegation(context, FaqListPage());
        });
      },
    );
  }
}
