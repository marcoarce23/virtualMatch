import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model;
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SenWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NoticiaEventoModel.dart'
    as model;

class Play extends StatefulWidget {
  static final String routeName = 'notificationList';
  Play({Key key}) : super(key: key);

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  //DEFINICION DE BLOC Y MODEL
  JugadorModelList entity = new JugadorModelList();
  model.JugadorModel entityModel = new model.JugadorModel();
  PlayerService entityGet = PlayerService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = Play.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    futureBuilder(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('CONOCE A LA COMUNIDAD'),
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
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              backgroundBasic(context),
              sizedBox(0.0, 8.0),
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    showInformationBasic(
                      context,
                      'CONOCE A NUESTROS JUGADORES',
                      'Busca y comunicate con los jugadores.',
                    ),
                    sizedBox(0.0, 2.0),
                    divider(),
                  ],
                ),
              ),
              //     futureBuilder(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      //  ),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),

      // floatButton(AppTheme.themeDefault, context,
      //   FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  futureBuilder(BuildContext context) {
    FutureBuilder(
        //  future: entityGet.getId(new model.JugadorModel(), 208),
        future: entityGet.getId(new model.JugadorModel(), int.parse(prefs.idPlayer)),
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
          model.JugadorModel entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(model.JugadorModel entity) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            sizedBox(0, 7),
            CardVM(
              size: 120,
              imageAssets: 'assets/icono3.png',
              opciones: avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
              accesosRapidos: opcionesLlamada(entity),
              listWidgets: [
                Text('Titulo: ${entity.nombre} ${entity.apellido} '),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${entity.nombre} ${entity.apellido}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'IPSDN: ${entity.idPsdn}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'Departamento: ${entity.idaDepartamento}',
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

  List<Widget> opcionesLlamada(model.JugadorModel entity) {
    return [
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          callNumber(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.phone, color: Colors.white, size: 27),
      ),
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          sendSMS(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.sms, color: Colors.white, size: 27),
      ),
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          callWhatsApp1(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 27),
      ),
    ];
  }
}
