import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
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
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new ListaTorneoModel()),
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
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        sizedBox(0, 7.0),
        Container(
          width: size.width * 0.95,
          margin: EdgeInsets.symmetric(vertical: 0.0),
          decoration: boxDecoration(),
          child: Column(
            children: <Widget>[
              gfListTileKey(
                  Key(entity.idTorneo.toString()),
                  Column(
                    children: [
                      Text(
                        'TÍTULO : ${entity.nombreTorneo}',
                        style: TextStyle(
                          color: AppTheme.themeWhite,
                        ),
                      ),
                      Text(
                        'TIPO: ${entity.tipoCompeticion}',
                        style: TextStyle(
                          color: AppTheme.themeWhite,
                        ),
                      ),
                    ],
                  ),
                  Text('DETALLE: ${entity.detalle}',
                      style: TextStyle(color: AppTheme.themeWhite)),
                  Align(
                      alignment: Alignment.centerRight,
                      child: _simplePopup(entity.idTorneo.toString(),
                          entity.idTipoCompeticion.toString())),
                  //_showAction(entity, entity.idTorneo.toString()),
                  null,
                  null, //avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
                  EdgeInsets.all(0.0),
                  EdgeInsets.all(0.0)),
            ],
          ),
        ),
      ],
    );
    //Text(entity.nombreEquipo);
  }

  _update() {
    entityModel.states = StateEntity.Update;
    entityModel.usuarioAuditoria = prefs.email;

    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.edit,
        color: AppTheme.themePurple,
        size: 25,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }

  _delete(String keyId) {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.trashAlt,
        color: AppTheme.themePurple,
        size: 25,
      ),
      onTap: () {
        setState(() {
          //    entityModel.idTorneo = int.parse(keyId);
          //     print('eliminar ${entityModel.idTorneo}');
          //      executeDelete(entityModel.idTorneo.toString(), prefs.email);
        });
      },
    );
  }

  _complete(String keyId) {
    return Row(
      children: [
        Text('Agregar:', style: TextStyle(color: AppTheme.themeWhite)),
        sizedBox(10, 0),
        InkWell(
          //  key: Key(keyId),
          child: FaIcon(
            FontAwesomeIcons.users,
            color: AppTheme.themePurple,
            size: 25,
          ),
          onTap: () {
            setState(() {
              //    entityModel.idTorneo = int.parse(keyId);
              //     print('eliminar ${entityModel.idTorneo}');
              //      executeDelete(entityModel.idTorneo.toString(), prefs.email);
            });
          },
        ),
      ],
    );
  }

  void generateTournament(String tipoCompetencia, String keyId) {
    if (tipoCompetencia == '27')
      _executeGenerator('/api/Torneo/execGenerarPlayOff/' +
          keyId +
          '/usuario/' +
          prefs.email);
    else
      _executeGenerator(
          '/api/Torneo/execGenerarLiga/' + keyId + '/usuario/' + prefs.email);
  }

  void executeDelete(String id, String usuario) async {
    // try {
    //   await entityService.delete(id, usuario, prefs.email).then((result) {
    //     print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
    //     if (result["tipo_mensaje"] == '0')
    //       showSnackbar(STATUS_OK, scaffoldKey);
    //     else
    //       showSnackbar(STATUS_ERROR, scaffoldKey);
    //   });
    // } catch (error) {
    //   showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    // }
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

  _executeGenerator(String url) {
    try {
      entityService.execute(API + url).then((result) {
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        if (result["tipo_mensaje"] == '3')
          showSnackbar(result["mensaje"], scaffoldKey);
        if (result["tipo_mensaje"] == '2')
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar('El torneo ya se ha iniciado.!!! ', scaffoldKey);
    }
  }

  Widget _simplePopup(String idTorneo, String idTipoCompeticion) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          /*
          PopupMenuItem(
            value: 1,
            child: Text("Editar"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Eliminar"),
          ),
          */
          PopupMenuItem(
            value: 3,
            child: Text("Adicionar jugadores"),
          ),
          PopupMenuItem(
            value: 4,
            child: Text("Iniciar el torneo"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              print('Editar');
              //_update();
              break;
            case 2:
              print('Eliminar');
              //_delete(idTorneo);
              break;
            case 3:
              print('Adicionar jugadores');
              _complete(idTorneo);
              break;
            case 4:
              print('Empezar torneo');
              generateTournament(idTipoCompeticion, idTorneo);
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
} // FIN DE LA CLASE
