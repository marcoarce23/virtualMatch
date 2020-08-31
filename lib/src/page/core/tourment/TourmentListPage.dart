import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/TorneoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/service/crudService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
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
  TorneoModel entity = new TorneoModel();
  model.TorneoModel entityModel = new model.TorneoModel();
  CrudService entityService;
  CrudService entityGet = CrudService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = TourmentListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    entityService = Provider.of<CrudService>(context);

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              backgroundBasic(context),
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.95,
                      margin: EdgeInsets.symmetric(vertical: 0.0),
                      // decoration: boxDecoration(),
                      child: Column(
                        children: <Widget>[
                          sizedBox(0, 10),
                          showInformationBasic(
                            context,
                            'TORNEOS CREADOS',
                            'Listado de los torneos disponibles para administralos Virtual Match',
                          ),
                        ],
                      ),
                    ),
                    divider(),
                    sizedBox(0.0, 7.0),
                  ],
                ),
              ),
              //       futureBuilder(context),
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
        future: entityGet.get(new TorneoModel(), ''),
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
          TorneoModel entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(TorneoModel entity) {
    return Container(
      child: gfListTileKey(
          Key(entity.idTorneo.toString()),
          Text(entity.nombre),
          Text(entity.detalle),
          _showAction(entity, entity.idTorneo.toString()),
          null,
          avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
          EdgeInsets.all(5.0),
          EdgeInsets.all(3.0)),
    );
    //Text(entity.nombreEquipo);
  }

  Widget _showAction(TorneoModel entity, String keyId) {
    return Row(
      children: <Widget>[
        Text('Operacionesss: $keyId'),
        sizedBox(10, 0),
        _update(),
        sizedBox(10, 0),
        _delete(keyId),
      ],
    );
  }

  Widget _header() {
    return gfListTileText(
        'TORNEOS: Virtual Match',
        'Detalle de los torneos creando.',
        FaIcon(FontAwesomeIcons.infoCircle),
        avatarSquare(IMAGE_LOGO, 35.0),
        EdgeInsets.all(5.0),
        EdgeInsets.all(3.0));
  }

  _update() {
    entityModel.states = StateEntity.Update;
    entityModel.usuarioAuditoria = prefs.email;

    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.edit,
        color: AppTheme.themeDefault,
        size: 20,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }

  _delete(String keyId) {
    return InkWell(
      key: Key(keyId),
      child: FaIcon(
        FontAwesomeIcons.trashAlt,
        color: AppTheme.themeDefault,
        size: 20,
      ),
      onTap: () {
        setState(() {
          entityModel.idTorneo = int.parse(keyId);
          print('eliminar ${entityModel.idTorneo}');
          executeDelete(entityModel.idTorneo.toString(), prefs.email);
        });
      },
    );
  }

  void executeDelete(String id, String usuario) async {
    try {
      await entityService.delete(id, usuario, '').then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(STATUS_OK, scaffoldKey);
        else
          showSnackbar(STATUS_ERROR, scaffoldKey);
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
          showSnackbar(STATUS_OK, scaffoldKey);
        else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
} // FIN DE LA CLASE
