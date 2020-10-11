import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/EquipoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentLoadPage.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/EquipoModel.dart'
    as model;

class EquipmentListPage extends StatefulWidget {
  static final String routeName = 'equipmentList';
  EquipmentListPage({Key key}) : super(key: key);

  @override
  _EquipmentListPageState createState() => _EquipmentListPageState();
}

class _EquipmentListPageState extends State<EquipmentListPage> {
  //DEFINICION DE BLOC Y MODEL
  EquipoModel entity = new EquipoModel();
  model.EquipoModel entityModel = new model.EquipoModel();
EquipmentService entityService;
  EquipmentService entityGet = EquipmentService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = EquipmentListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    entityService = Provider.of<EquipmentService>(context);

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
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
                        'ADMINISTRA TUS EQUIPOS',
                        'En esta pantalla puedes modificar y eliminar (mientras no se inscribiste con el equipo) tus equipos que hayas creado anteriormente.',),
                    dividerBlack(),
                  ],
                ),
              ),
              futureBuilder(context),
              copyRigthBlack(),
            ],
          ),
        ),
      ),
       floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.playstation), EquipmentAllPage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get (new EquipoModel()),
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
          EquipoModel entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(EquipoModel entity) {
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
                  Key(entity.idEquipo.toString()),
                  Text('Equipo: ${entity.nombre}'),
                  Text('Detalle: ${entity.detalle}'),
                  _showAction(entity, entity.idEquipo.toString()),
                  null,
                  avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
                  EdgeInsets.all(5.0),
                  EdgeInsets.all(3.0)),
            ],
          ),
        ),
      ],
    );
    //Text(entity.nombreEquipo);
  }

  Widget _showAction(EquipoModel entity, String keyId) {
    return Row(
      children: <Widget>[
        Text('Operaciones: $keyId'),
        sizedBox(10, 0),
        _update(),
        sizedBox(10, 0),
        _delete(keyId),
      ],
    );
  }

 
  _update() {
    entityModel.states = StateEntity.Update;
    entityModel.usuarioAuditoria = prefs.email;

    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.edit,
        color: AppTheme.themePurple,
        size: 23,
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
        color: AppTheme.themePurple,
        size: 23,
      ),
      onTap: () {
        setState(() {
          entityModel.idEquipo = int.parse(keyId);
          print('eliminar ${entityModel.idEquipo}');
          executeDelete(entityModel.idEquipo.toString(), prefs.email);
        });
      },
    );
  }

  void executeDelete(String id, String usuario) async {
    try {
      await entityService.delete(id, usuario).then((result) {
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
      NotificationService entityService, model.EquipoModel entity) async {
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