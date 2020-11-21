import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/player/PlayerSelectionPage.dart';
import 'package:virtual_match/src/page/core/tourment/CustomizePlayer.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/TorneoModelo.dart'
    as model;

class TourmentListPage extends StatefulWidget {
  static final String routeName = 'tourmentList';
  TourmentListPage({Key key}) : super(key: key);

  @override
  _TourmentListPageState createState() => _TourmentListPageState();
}

class _TourmentListPageState extends State<TourmentListPage> {
  //DEFINICION DE BLOC Y MODEL
  ListaTorneoModel entity = new ListaTorneoModel();
  model.TorneoModel entityModel = new model.TorneoModel();
  TourmentService entityService = new TourmentService();
  TourmentService entityGet = new TourmentService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PlayerService entityGet1 = PlayerService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //  entityService = Provider.of<TourmentService>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('CREACIÓN DEL TORNEO'),
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
                child: Column(
                  children: <Widget>[
                    sizedBox(0.0, 8),
                    showInformationBasic(
                      context,
                      'INICIA EL TORNEO VIRTUAL MATCH',
                      'En esta pantalla puedes iniciar el torneo y agregar personas que faltantes.',
                    ),
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
      floatingActionButton: floatButtonImage(Colors.transparent, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new ListaTorneoModel(), 1),
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
          ListaTorneoModel entity = snapshot.data[index];
          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(ListaTorneoModel entity) {
    return Column(
      children: <Widget>[
        sizedBox(0, 7.0),
        CardVM(
          size: 300,
          imageAssets: 'assets/icono3.png',
          opciones: _simplePopup(entity, entity.idTorneo.toString()),
          accesosRapidos: null,
          listWidgets: [
            avatarCircleTransparent(entity.foto, 45),
            sizedBox(0, 7),
            Text('DETALLE: ${entity.idTorneo}',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text(
              'TORNEO : ${entity.nombreTorneo}',
              style: TextStyle(
                color: AppTheme.themeWhite,
              ),
            ),
            Text('COMPETICIÓN: ${entity.tipoCompeticion}',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text('MODALIDAD: ${entity.tipoModalidad}',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text('DETALLE: ${entity.detalle}',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text('HASTAG: ${entity.hashTag}',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text('PREMIOS: ${entity.premios}',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text(
                'FECHA TORNEO: ${entity.fechaInicio.toString().substring(0, 10)}',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text(
                'INSCRITOS: ${entity.cantidadInscritos}/${entity.cantidadJugadores}',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text((entity.conBoot == 1) ? 'Generado con jugadores boots' : '',
                style: TextStyle(color: AppTheme.themeWhite)),
            Text((entity.es11vs11 == 1) ? '11 Vs. 11 : SI' : '11 Vs. 11 : NO',
                style: TextStyle(color: AppTheme.themeWhite)),
          ],
        ),
      ],
    );
    //Text(entity.nombreEquipo);
  }

  Widget _simplePopup(ListaTorneoModel entity, String keyId) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: -1,
            enabled: (entity.conBoot == 1) ? true : false,
            child: Text("Cerrar torneo sin boots"),
          ),
          PopupMenuItem(
            value: 0,
            enabled: (entity.conBoot == 1) ? true : false,
            child: Text("Reemplazar boots"),
          ),
          PopupMenuItem(
            value: 1,
            enabled: (entity.conBoot == 1) ? false : true,
            child: Text("Registrar Jugadores/Equipos"),
          ),
          PopupMenuItem(
            value: 2,
            enabled: (entity.conBoot == 1) ? false : true,
            child: Text("Empezar el torneo"),
          ),
          PopupMenuItem(
            value: -2,
            child: Text("Empezar torneo elimintaria ( Fase grupo)"),
          ),
          PopupMenuItem(
            value: 3,
            child: Text("Editar Torneo"),
          ),
          PopupMenuItem(
            value: 4,
            child: Text("Eliminar Torneo"),
          ),
        ],
        onCanceled: () {},
        onSelected: (value) {
          switch (value) {
            case -1:
              cerrarTorneo(
                entity.idTorneo,
              );
              break;
            case 0:
              navegation(
                  context,
                  CustomizePlayer(
                    idTorneo: entity.idTorneo,
                  ));
              break;
            case 1:
              navegation(
                  context,
                  PlayerSelectionVMPage(
                      idTorneo: entity.idTorneo,
                      torneo: entity.nombreTorneo,
                      competicion: entity.tipoCompeticion,
                      modalidad: entity.tipoModalidad,
                      vs11: entity.es11vs11));
              break;
            case -2:
              _executeGenerator(
                  '/api/TorneoFaseGrupo/execGenerarPlayOffGrupo/' +
                      keyId +
                      '/usuario/' +
                      prefs.email);
              break;
            case 2:
              _start(keyId, entity.idTipoCompeticion.toString());
              break;
            case 3:
              Navigator.pushNamed(context, 'tourmnetLoad', arguments: entity);
              break;

            case 4:
              entity.idTorneo = int.parse(keyId);
              executeDelete(entity.idTorneo.toString(), prefs.email);
              break;
            default:
              showSnackbarWithOutKey("No hay opción seleccionada", context);
              break;
          }
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
          size: 30,
        ),
        offset: Offset(0, 100),
      );

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      JugadorModel item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.idPsdn + ' - ' + item.nombre + ' ' + item.apellido),
        value: item.idJugador.toString(),
      ));
    }
    return lista;
  }

  void executeDelete(String id, String usuario) async {
    try {
      await entityService
          .delete(
        id,
        usuario,
      )
          .then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
           setState(() {
            showSnackbar(result["mensaje"], scaffoldKey);
          });
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }

  _start(String keyId, String modalidad) {
    print('MODALIDADDD: $modalidad');
    if (modalidad == '27')
      _executeGenerator('/api/Torneo/execGenerarPlayOff/' +
          keyId +
          '/usuario/' +
          prefs.email);
    else if (modalidad == '28')
      _executeGenerator(
          '/api/Torneo/execGenerarLiga/' + keyId + '/usuario/' + prefs.email);
    else
      _executeGenerator('/api/TorneoFaseGrupo/execGenerarLigaGrupo/' +
          keyId +
          '/usuario/' +
          prefs.email);
  }

  void cerrarTorneo(int idTorneo) async {
    try {
      await entityService.cerrarElTorneo(idTorneo).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }

  void executeUpdate(
      TourmentService entityService, model.TorneoModel entity) async {
    try {
      await entityService.repository(entity).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }

  void _executeGenerator(String url) async {
    print('EL URLLL: $url}');
    try {
      await entityService.execute(API + url).then((result) {
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(
          'No puede empezar el torneo porque aún no se completó la cantidad de jugadores inscritos!!',
          scaffoldKey);
    }
  }
} // FIN DE LA CLASE
