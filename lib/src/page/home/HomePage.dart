import 'dart:io';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/notification/NotificationPage.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/menu/CircularMenu.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = new Preferense();
  File photo;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    // generic.add(
    //     new TokenImei(
    //         correo1: prefs.correoElectronico,
    //         imei: prefs.imei,
    //         token: prefs.token),
    //     urlAddTokenImei);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    prefs.lastPage = HomePage.routeName;
    return SafeArea(
      left: true,
      right: true,
      bottom: true,
      top: true,
      child: Scaffold(
        appBar: appBar('Virtual Match - Sorojchi eclub'),
        body: NotificationPage(),
        drawer: DrawerMenu(),
        floatingActionButton: new CircularMenu(),
        bottomNavigationBar: new BottonNavigation(),
      ),
    );
  }
}
