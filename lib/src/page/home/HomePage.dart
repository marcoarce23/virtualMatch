import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Const.dart';

import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/core/foldable/FoldablePage.dart';
import 'package:virtual_match/src/page/faq/FaqPage.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/image/ImagePanoramaPage.dart';
import 'package:virtual_match/src/page/people/InfluencerListPage.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/image/ImageWidget.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = new Preferense();
  //final generic = new Generic();
  int _selectedIndex = 0;
  int valorExpedido = 60;
  File photo;

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
        appBar: AppBar(
            backgroundColor: AppTheme.themeBlackGrey,
            toolbarOpacity: 1.0,
            iconTheme: IconThemeData(color: AppTheme.themeDefault, size: 12),
            elevation: 5,
            title: Row(
              children: <Widget>[
                Text(
                  "Virtual Match ",
                  style: kTitleAppBar,
                  textAlign: TextAlign.center,
                ),
                sizedBox(10.0, 0.0),
                FaIcon(
                  FontAwesomeIcons.playstation,
                  color: AppTheme.themeDefault,
                  size: 18,
                ),
              ],
            )),
        body: metodoHome(),
        drawer: DrawerMenu(), // drawer(context),
        bottomNavigationBar: _bottomNavigationBar(context),
      ),
    );
  }

  Widget metodoHome() {
    return Stack(
      children: <Widget>[
         // fondoApp(),

        SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[],
                  ),
                ),
                //  _crearExpedido(),
                showPictureOval(photo, imgDefault, 130.0),
                _botonesRedondeados(),

                Text(
                  'versión 1.0.0',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FaqPage()),
        );
      }

      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientListPage()),
        );
      }
      if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }


  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      elevation: 3.0,
      type: BottomNavigationBarType.shifting,
      showSelectedLabels: true,
      backgroundColor: AppTheme.themeBlackGrey,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone,
                size: 20.0, color: AppTheme.themeDefault),
            title: Text('Noticias')),
        BottomNavigationBarItem(
            icon: Icon(Icons.event_available,
                size: 20.0, color: AppTheme.themeDefault),
            title: Text('Torneo')),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.ondemand_video,
              size: 20.0,
              color: AppTheme.themeDefault,
            ),
            title: Text('Virtual')),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.ondemand_video,
              size: 20.0,
              color: AppTheme.themeDefault,
            ),
            title: Text('Registrate')),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.ondemand_video,
              size: 20.0,
              color: AppTheme.themeDefault,
            ),
            title: Text('Menu')),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppTheme.themeDefault,
      onTap: _onItemTapped,
    );
  }

  Widget _botonesRedondeados() {
    return Wrap(children: <Widget>[
      _crearBotonRedondeado(
          Colors.purpleAccent,
          FaIcon(FontAwesomeIcons.fileImage, color: Colors.white, size: 35.0),
          'Catálogos',
          '2',
          16.0,
          ClientListPage(),
          0,
          ""),
      _crearBotonRedondeado(
          Colors.blue,
          FaIcon(FontAwesomeIcons.home, color: Colors.white, size: 35.0),
          'Productos',
          '1',
          14.0,
          ClientListPage(),
          0,
          ""),
      _crearBotonRedondeado(
          Colors.pinkAccent,
          FaIcon(FontAwesomeIcons.image, color: Colors.white, size: 35.0),
          'Album de Servicios',
          '3',
          14.0,
          ClientListPage(),
          0,
          ""),
      _crearBotonRedondeado(
          Colors.deepPurple,
          FaIcon(FontAwesomeIcons.userTie, color: Colors.white, size: 40.0),
          'Clientes',
          '5',
          15.0,
          ClientListPage(),
          0,
          ""),
      _crearBotonRedondeado(
          Colors.deepPurple,
          FaIcon(FontAwesomeIcons.store, color: Colors.white, size: 40.0),
          '360°',
          '6',
          15.0,
          ImapePanoramaPage(),
          0,
          ""),
      _crearBotonRedondeado(
          Colors.green,
          FaIcon(FontAwesomeIcons.gratipay, color: Colors.white, size: 35.0),
          'Mis Favoritos',
          '6',
          16.0,
          FoldablePage(),
          0,
          ""),
    ]);
  }

  Widget _crearBotonRedondeado(Color color, FaIcon icono, String texto,
      String valor, double size, Widget widget, int acceso, String link) {
    return InkWell(
      onTap: () {
        if (acceso == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ViewPage(title: 'TEST DE PRUEBA', url: link)));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget),
          );
        }
      },
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 87.0,
            width: 160,
            margin: EdgeInsets.all(9.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                AppTheme.themeBlackGrey,
                AppTheme.themeBlackGrey,
                AppTheme.themeBlackGrey,
                AppTheme.themeBlackGrey,
              ],
            )),
            //  borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                CircleAvatar(
                  backgroundColor: color,
                  radius: 30.0,
                  child: icono,
                  //Icon(icono, color: Colors.white, size: 42.0),
                ),
                Text(texto,
                    style: TextStyle(color: AppTheme.themeDefault, fontSize: size)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
