import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/carousel/CarouselWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/menu/bottomMenu.dart';

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
  int _selectedRadio = 18;
  int _group = 0;

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
    List<CarouselSimpleModel> lista = [
      CarouselSimpleModel(
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Carrusel%2C_tio_vivo_Albacete.jpg/1024px-Carrusel%2C_tio_vivo_Albacete.jpg',
          textFromImage: 'text'),
      CarouselSimpleModel(
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/LakesideParkCarousel.jpg/1200px-LakesideParkCarousel.jpg',
          textFromImage: 'sello'),
    ];

    prefs.lastPage = HomePage.routeName;

    return SafeArea(
      left: true,
      right: true,
      bottom: true,
      top: true,
      child: Scaffold(
        appBar: appBar('Virtual Match'),
        body: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/portada1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                //  FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
                SizedBox(width: 5.0),
                Text('Noticias'),
                Radio(
                  value: 0,
                  groupValue: _group,
                  onChanged: (T) {
                    _selectedRadio = 18;
                    setState(() {
                      _group = T;
                    });
                  },
                ),
                Text('Eventos'),
                Radio(
                  value: 1,
                  groupValue: _group,
                  onChanged: (T) {
                    _selectedRadio = 19;
                    setState(() {
                      _group = T;
                    });
                  },
                ),
                Text('Multimedia'),
                Radio(
                  value: 2,
                  groupValue: _group,
                  onChanged: (T) {
                    _selectedRadio = 15;
                    setState(() {
                      _group = T;
                    });
                  },
                ),
              ],
            ),

                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: CarouselSimple(
                          lista, AppTheme.themePurple, AppTheme.themeWhite)),
                ),
                sizedBox(0, 10),
                CardVM(
                  size: 150,
                  imageAssets: 'assets/icono3.png',
                  opciones: _simplePopup(),
                  accesosRapidos: xxxx(),
                  listWidgets: [
                    Text(
                      "sssss",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                /*
                CardVM(
                  size: 150,
                  imageAssets: 'assets/icono3.png',
                  opciones: _simplePopup(),
                  accesosRapidos: xxxx(),
                  listWidgets: [
                    Text(
                      "xxxxx",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "sdasdasd",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "dsdfsdf",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "asdasdasd",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "asdasdasd",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "asdasdasd",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                */
              ],
            ),
          ),
        ),
        drawer: DrawerMenu(),
        bottomNavigationBar: new BottonNavigation(),
      ),
    );
  }

  List<Widget> xxxx() {
    return [
      sizedBox(30, 0),
      InkWell(
          child: FaIcon(
            FontAwesomeIcons.whatsapp,
            color: AppTheme.themeWhite,
            size: 35,
          ),
          onTap: () {
            print('ss');
          }),
      sizedBox(30, 0),
      InkWell(
          child: FaIcon(
            FontAwesomeIcons.whatsapp,
            color: AppTheme.themeWhite,
            size: 35,
          ),
          onTap: () {
            print('ss');
          }),
      sizedBox(30, 0),
      InkWell(
          child: FaIcon(
            FontAwesomeIcons.whatsapp,
            color: AppTheme.themeWhite,
            size: 35,
          ),
          onTap: () {
            print('ss');
          }),
    ];
  }

  Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Ver detalle"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Inscribirse al torneo"),
          ),
          PopupMenuItem(
            value: 3,
            child: Text("Salir del torneo"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              showSnackbarWithOutKey("No hay opcion seleccionada", context);
              break;
            case 2:
              showSnackbarWithOutKey("No hay opcion seleccionada", context);
              break;
            case 3:
              showSnackbarWithOutKey("No hay opcion seleccionada", context);
              break;
            default:
              showSnackbarWithOutKey("No hay opcion seleccionada", context);
              break;
          }
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        offset: Offset(0, 100),
      );

  Positioned menu() {
    Size tamanioPantalla = MediaQuery.of(context).size;
    return Positioned(
        bottom: 35,
        child: Container(
            width: tamanioPantalla.width,
            child: Align(alignment: Alignment.center, child: BottomMenu())));
  }
}
