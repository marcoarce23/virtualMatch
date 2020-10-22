import 'dart:io';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NoticiaEventoModel.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/service/NewService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/card/CardSlideProductWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

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
              return Text("sss");
              break;
            default:
              return listView(grupo, context, snapshot);
          }
        });
  }

  Widget listView(int grupo, BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;
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
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                decoration: containerImage2(),
                width: size.width * 0.98,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gfCardAdvanced(
                        context,
                        "Publicado en fecha ${entity.fecha}",
                        " ${entity.titulo}",
                        "Dirigido a: ${entity.dirigidoa} \n Descripción: ${entity.dirigidoa}",
                        2,
                        entity.foto),
                  ],
                ),
              ),
              Positioned(
                top: 25,
                right: 50,
                child: Opacity(
                  opacity: 0.5,
                  child: avatarCircle(IMAGE_LOGOB, 25),
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
        appBar: appBar('VIRTUAL MATCH'),
        body: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/portada2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox(0.0, 5.0),
                // Center(
                //   child: Image(
                //     image: NetworkImage(IMAGE_SCREEN3),
                //     height: 180.0,
                //     fit: BoxFit.fill,
                //   ),
                // ),
                CardSlideBalckWidget(),

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
                      activeColor: AppTheme.themeWhite,
                      focusColor: AppTheme.themePurple,
                      hoverColor: AppTheme.themePurple,
                      //      autofocus: true,
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
                      activeColor: AppTheme.themeWhite,
                      focusColor: AppTheme.themePurple,
                      hoverColor: AppTheme.themePurple,
                      //   autofocus: true,
                      value: 1,
                      groupValue: _group,
                      onChanged: (T) {
                        _selectedRadio = 19;
                        setState(() {
                          _group = T;
                        });
                      },
                    ),
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
