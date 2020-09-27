import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';

class NotificationPage extends StatefulWidget {
  static final String routeName = 'notificationPage';
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  //DEFINICION DE BLOC Y MODEL
  NotificacionModel entity = new NotificacionModel();
  NotificationService entityGet = NotificationService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();

  @override
  void initState() {
    prefs.lastPage = NotificationPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // entityService = Provider.of<NotificationService>(context);
    return Scaffold(
      appBar: appBar('COMUNIDAD 24/7.'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/portada2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              backgroundBasic(context),
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                // decoration: boxDecoration(),
                child: Column(
                  children: <Widget>[
                    sizedBox(0, 10),
                    showInformationBasic(
                      context,
                      'TE MANTENEMOS INFORMADO?',
                      'Las noticias y eventos más importantes y de primera mano. Comunidad FIFA BOLIVIA 24/7.',
                    ),
                  ],
                ),
              ),
              divider(),
              sizedBox(0.0, 7.0),
              futureBuilder(context),
              //   copyRigth(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new NotificacionModel()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listView(context, snapshot);
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          NotificacionModel entity = snapshot.data[index];

          return _showListTile(entity, context);
        },
      ),
    );
  }

  Widget _showListTile(NotificacionModel entity, BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            sizedBox(0, 7),
            CardVM(
              size: 90,
              imageAssets: 'assets/icono3.png',
              //   opciones: avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
              listWidgets: [
                Text('Notificación: ${entity.titulo} '),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'TITULO: ${entity.titulo}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'DETALLE: ${entity.detalle}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'FECHA: ${entity.fechacreacion}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
