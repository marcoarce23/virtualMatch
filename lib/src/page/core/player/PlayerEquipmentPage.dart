import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/EquipoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class PlayerEquipmentPage extends StatefulWidget {
  static final String routeName = 'player11vs11';
  @override
  _PlayerEquipmentPageState createState() => _PlayerEquipmentPageState();

  int grupo;

  PlayerEquipmentPage({this.grupo});
}

class _PlayerEquipmentPageState extends State<PlayerEquipmentPage> {
  //DEFINICION DE BLOC Y MODEL
  JugadorEquipoModelList entity = new JugadorEquipoModelList();
  PlayerService entityGet = PlayerService();
  EquipoStateModel entityStateModel = new EquipoStateModel();
  EquipmentService entityService = new EquipmentService();

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
      appBar: appBar('TUS JUGADORES'),
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
        future: entityGet.getMisJugadores(new JugadorEquipoModelList(), '198'),
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
          JugadorEquipoModelList entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(JugadorEquipoModelList entity) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            sizedBox(0, 7),
            CardVM(
              size: 170,
              imageAssets: 'assets/icono3.png',
              opciones: avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
              accesosRapidos: opcionesLlamada(entity),
              listWidgets: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'EQUIPO: ${entity.nombreEquipo}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'DETALLE: ${entity.detalle}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'JUGADOR: ${entity.nombreJugador}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'IPSDN: ${entity.psdnJugador}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'CAPITAN:  ${entity.esCapitan == 1 ? 'ES EL CAPITAN' : 'JUGADOR'}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'ESTADO: ${entity.estado == 1 ? 'VIGENTE' : entity.estado == 0 ? 'SOLICITUD' : entity.estado == 3 ? 'INACTIVO' : entity.estado == 2 ? 'DESEO SALIRME' : 'sin estado'}',
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

  List<Widget> opcionesLlamada(JugadorEquipoModelList entity) {
    return [
      sizedBox(20, 0),
      InkWell(
        onTap: () {
          callWhatsAppText(int.parse(entity.telefonoJugador),
              '*/FIFERO :${entity.nombreJugador}. Deseo contactarme contigo. Saludos Fifero*/');
        },
        child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 27),
      ),
      sizedBox(20, 0),
      InkWell(
        onTap: () {
          loadingEntity(1, entity.idJugador, entity.idEquipo);
        },
        child:
            FaIcon(FontAwesomeIcons.handPointUp, color: Colors.white, size: 27),
      ),
      sizedBox(20, 0),
      InkWell(
        onTap: () {
          loadingEntity(3, entity.idJugador, entity.idEquipo);
        },
        child: FaIcon(FontAwesomeIcons.handPointDown,
            color: Colors.white, size: 27),
      ),
    ];
  }

  void loadingEntity(int estado, int idJugador, int idEquipo) {
    entityStateModel.states = StateEntity.None;
    entityStateModel.idEquipo = idEquipo;
    entityStateModel.idJugador = idJugador;
    entityStateModel.estado = estado;

    executeUpdateCUD(entityService, entityStateModel);
  }

  void executeUpdateCUD(
      EquipmentService entityService, EquipoStateModel entity) async {
    try {
      await entityService.repository(entity).then((result) {
        print('EL RESULTTTTT CAMBIO ESTADO: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(STATUS_OK, scaffoldKey);
        else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
}
