import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NoticiaEventoModel.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/service/NewService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/carousel/CarouselWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/widget/menu/bottomMenu.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificacionModel entity = new NotificacionModel();
  NewService entityGet = NewService();

  // DEFINICIOND E VARIABLES
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

  Widget futureBuilderNoticias(BuildContext context, int grupo) {
    return FutureBuilder(
        future: entityGet.get(new NoticiaEventoModel()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listView(grupo, context, snapshot);
            /*
              List lis = snapshot.data;

              for (var i = 0; i < lis.length; i++) {
                NoticiaEventoModel ent = lis[i];

                if (grupo == 0) {
                  if (ent.tipo == 0) {
                    CarouselSimpleModel card = CarouselSimpleModel(
                        imageUrl: ent.foto, textFromImage: ent.titulo);
                    lista.add(card);
                  }
                } else {
                  if (ent.tipo == 1) {
                    CarouselSimpleModel card = CarouselSimpleModel(
                        imageUrl: ent.foto, textFromImage: ent.titulo);
                    lista.add(card);
                  }
                }
              }

              return CarouselSimple(
                  lista, AppTheme.themePurple, AppTheme.themeWhite);
                  */

          }
        });
  }

  Widget listView(int grupo, BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        NoticiaEventoModel entity = snapshot.data[index];
        if (entity.tipo == grupo) {
          return Stack(
            children: [
              gfCardAdvanced(
                  "Publicado en fecha ${entity.fecha}",
                  " ${entity.titulo}",
                  "Dirigido a: ${entity.dirigidoa} \n Descripción: ${entity.dirigidoa}",
                  2,
                  entity.foto),
              Positioned(
                bottom: 18,
                right: 15,
                child: Opacity(
                  opacity: 0.6,
                  child: Image.network(
                    IMAGE_LOGO,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
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
        appBar: appBar('LO ÚLTIMO '),
        body: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/portada2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    //  FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
                    SizedBox(width: 5.0),
                    Text('Noticias',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppTheme.themeWhite)),
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
                    Text('Eventos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppTheme.themeWhite)),
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
                    /*
                    Text('Multimedia',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppTheme.themeWhite)),
                    Radio(
                      value: 2,
                      groupValue: _group,
                      onChanged: (T) {
                        _selectedRadio = 15;
                        setState(() {
                          _group = T;
                        });
                      },
                    ),*/
                  ],
                ),
                futureBuilderNoticias(context, _group),
                sizedBox(0, 10),
              ],
            ),
          ),
        ),
        drawer: DrawerMenu(),
        bottomNavigationBar: new BottonNavigation(),
      ),
    );
  }
}
