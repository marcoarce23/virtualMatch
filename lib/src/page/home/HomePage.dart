import 'dart:io';
import 'dart:ui';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_match/src/model/util/Const.dart';

import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentPlayersTournament.dart';
import 'package:virtual_match/src/page/core/foldable/FoldablePage.dart';
import 'package:virtual_match/src/page/core/player/PlayerLoadPage.dart';
import 'package:virtual_match/src/page/core/tourment/PositionTable.dart';
import 'package:virtual_match/src/page/core/tourment/TournamentPlayerScored.dart';
import 'package:virtual_match/src/page/event/EventLoadPage.dart';
import 'package:virtual_match/src/page/faq/FaqListPage.dart';
import 'package:virtual_match/src/page/faq/FaqPage.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
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
  File _imageFile;

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
        appBar: AppBar(
            backgroundColor: AppTheme.themeBlackBlack,
            // toolbarOpacity: 1.0,
            iconTheme: IconThemeData(color: AppTheme.themeWhite, size: 15),
            elevation: 5,
            title: Row(
              children: <Widget>[
                Text(
                  "Virtual Match ",
                  style: kTitleAppBar,
                  textAlign: TextAlign.center,
                ),
                sizedBox(125.0, 0.0),
                FaIcon(
                  FontAwesomeIcons.playstation,
                  color: AppTheme.themeWhite,
                  size: 25,
                ),
              ],
            )),
        body: metodoHome(),
        drawer: DrawerMenu(),
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            // Cannot be `Alignment.center`
            alignment: Alignment.bottomRight,
            ringColor: Colors.white.withAlpha(25),
            ringDiameter: 500.0,
            ringWidth: 150.0,
            fabSize: 64.0,
            fabElevation: 8.0,

            // Also can use specific color based on wether
            // the menu is open or not:
            // fabOpenColor: Colors.white
            // fabCloseColor: Colors.white
            // These properties take precedence over fabColor
            fabColor: AppTheme.themeWhite,
            fabOpenIcon: Icon(Icons.menu, color: AppTheme.themeBlackGrey),
            fabCloseIcon: Icon(Icons.close, color: AppTheme.themeBlackGrey),
            fabMargin: const EdgeInsets.all(16.0),
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            onDisplayChange: (isOpen) {
              _showSnackBar(context,
                  "Menu Virtual Match ${isOpen ? "abierto" : "cerrado"}");
            },
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  _showSnackBar(context, "Selecciono  1");
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: FaIcon(FontAwesomeIcons.shoppingCart,
                    color: AppTheme.themeDefault, size: 25.0),
              ),
              RawMaterialButton(
                onPressed: () async {
                  _imageFile =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: FaIcon(FontAwesomeIcons.images,
                    color: AppTheme.themeDefault, size: 25.0),
              ),
              RawMaterialButton(
                onPressed: () async {
                  _imageFile =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: FaIcon(FontAwesomeIcons.images,
                    color: AppTheme.themeDefault, size: 25.0),
              ),
              RawMaterialButton(
                onPressed: () {
                  navegation(context, PlayerLoadPage());
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: FaIcon(FontAwesomeIcons.users,
                    color: AppTheme.themeDefault, size: 25.0),
              ),
              RawMaterialButton(
                onPressed: () {
                  _showSnackBar(context, "Selecciono Cerrar Menu Circular");
                  fabKey.currentState.close();
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: FaIcon(FontAwesomeIcons.timesCircle,
                    color: AppTheme.themeDefault, size: 25.0),
              )
            ],
          ),
        ), // drawer(context),
        bottomNavigationBar: convexAppBar(),
      ),
    );
  }

  Widget convexAppBar() {
    return ConvexAppBar.badge(
      {0: '99+', 1: Icons.assistant_photo, 2: Colors.redAccent},

      backgroundColor: AppTheme.themeDefault,
      style: TabStyle.reactCircle,
      elevation: 3.0,
      items: [
        TabItem(icon: Icons.next_week, title: 'Noticias'),
        TabItem(icon: Icons.event_available, title: 'Evento'),
        TabItem(icon: Icons.add, title: 'Torneo', isIconBlend: true),
        TabItem(icon: Icons.gamepad, title: 'Jugadores'),
        TabItem(icon: Icons.notifications_active, title: 'Notific'),
      ],
      initialActiveIndex: 2, //optional, default as 0
      onTap: (value) {
        setState(() {
          if (value == 0) navegation(context, EventAllPage());
          if (value == 1) navegation(context, EventAllPage());
          if (value == 2) navegation(context, EventAllPage());
          if (value == 3) navegation(context, EventAllPage());
          if (value == 4) navegation(context, FaqListPage());
        });
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
      backgroundColor: Colors.pinkAccent,
    ));
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
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    stops: [0.1, 0.4, 0.7, 0.9],
                    colors: [
                      Colors.red,
                      Colors.red,
                      Colors.red,
                      Colors.red,
                    ],
                  )),
                  child: Column(
                    children: <Widget>[],
                  ),
                ),
                //  _crearExpedido(),
                showPictureOval(photo, IMAGE_DEFAULT, 130.0),
                //TournamentPlayerScored(idTorneo: 2,),
                //EquipmentPlayersTournament(idTorneo: 2,),
                PositionTable(idTorneo: 2,),
                //    _botonesRedondeados(),

                // Text(
                //   'versión 1.0.0',
                //   textAlign: TextAlign.left,
                // ),
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
                    style: TextStyle(
                        color: AppTheme.themeDefault, fontSize: size)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
