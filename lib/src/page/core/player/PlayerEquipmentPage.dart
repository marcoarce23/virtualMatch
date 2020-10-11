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

class PlayerEquipmentPage extends StatefulWidget {
  static final String routeName = 'playerEquipmentPage';
  PlayerEquipmentPage({Key key}) : super(key: key);

  @override
  _PlayerEquipmentPageState createState() => _PlayerEquipmentPageState();
}

class _PlayerEquipmentPageState extends State<PlayerEquipmentPage> {
  //DEFINICION DE BLOC Y MODEL
  JugadorModelList entity = new JugadorModelList();
  model.JugadorModel entityModel = new model.JugadorModel();
  PlayerService entityGet = PlayerService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = PlayerEquipmentPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      //  appBar: appBar('TUS JUGADORES'),
      // drawer: DrawerMenu(),
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
                      'TUS JUGADORES PARA 11 VS. 11',
                      'Busca, acepta y comunicate con tus jugadores.',
                    ),
                    sizedBox(0.0, 2.0),
                    divider(),
                  ],
                ),
              ),
              futureBuilder(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      //  ),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new model.JugadorModel()),
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
      sizedBox(20, 0),
      InkWell(
        onTap: () {
          callWhatsApp1(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 27),
      ),
      sizedBox(20, 0),
      InkWell(
        onTap: () {},
        child:
            FaIcon(FontAwesomeIcons.handPointUp, color: Colors.white, size: 27),
      ),
      sizedBox(20, 0),
      InkWell(
        onTap: () {
          callWhatsApp1(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.handPointDown,
            color: Colors.white, size: 27),
      ),
    ];
  }
}
