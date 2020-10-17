import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/EquipoModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentLoadPage.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
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
        appBar: appBar('INFORMACIÓN DE TU EQUIPO'),
        drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/portada2.png'),
              fit: BoxFit.cover,
            ),
          ),
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
                        'ADMINISTRA TU EQUIPO',
                        'En esta pantalla puedes modificar y eliminar y gestionar tu equipo creado.',
                      ),
                      sizedBox(0.0, 8),
                      Center(
                        child: Image(
                          image: NetworkImage(IMAGE_SCREEN3),
                          height: 180.0,
                          fit: BoxFit.fill,
                        ),
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
      ),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.playstation), EquipmentAllPage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getMisEquipos(new EquipoModel(), '198'),
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

  Widget _simplePopup(EquipoModel entity, int keyId, BuildContext context) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Editar"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Eliminar"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              Navigator.pushNamed(context, 'equipmentLoad', arguments: entity);
              break;
            case 2:
              //   entityModel.idEquipo = int.parse(keyId);

              setState(() {
                setState(() {
                  // entityModel.idEquipo = int.parse(keyId);
                  // print('eliminar ${entityModel.idEquipo}');
                  // executeDelete(entityModel.idEquipo.toString(), prefs.email);
                });
              });

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

  Widget _showListTile(EquipoModel entity) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            sizedBox(0, 7),
            CardVM(
              size: 150,
              imageAssets: 'assets/icono3.png',
              opciones: _simplePopup(entity, entity.agrupador, context),
              accesosRapidos: null,
              listWidgets: [
                avatarCircle(entity.foto, 55),
                sizedBox(0, 7),
                Text(
                  'TÍTULO : ${entity.nombre}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'DETALLE: ${entity.detalle}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ],
        ),
      ],
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
    setState(() {});
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
