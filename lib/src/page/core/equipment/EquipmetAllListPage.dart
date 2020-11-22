import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityMap/EquipoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/player/PlayerEditPage.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/EquipoModel.dart'
    as list;
import 'package:virtual_match/src/model/entity/EntityMap/EquipoModel.dart'
    as model;

class EquipmentAllListPage extends StatefulWidget {
  static final String routeName = 'equipmentList';
  EquipmentAllListPage({Key key}) : super(key: key);

  @override
  _EquipmentAllListPageState createState() => _EquipmentAllListPageState();
}

class _EquipmentAllListPageState extends State<EquipmentAllListPage> {
  //DEFINICION DE BLOC Y MODEL
  list.EquipoCapitanesModel entity = new list.EquipoCapitanesModel();
  model.EquipoModel entityModel = new model.EquipoModel();
  model.EquipoStateModel entityStateModel = new model.EquipoStateModel();
  EquipmentService entityService = new EquipmentService();
  EquipmentService entityGet = EquipmentService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = EquipmentAllListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                        'ELIGE TU EQUIPO',
                        'En esta pantalla podrás buscar los equipos inscritos y solicitar tu inscripción. Disfruta de  11 Vs. 11.',
                      ),
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
      floatingActionButton: floatButton(Colors.transparent, context,
          FaIcon(FontAwesomeIcons.arrowLeft), PlayerEditPage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getEquipos(new list.EquipoCapitanesModel()),
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
          list.EquipoCapitanesModel entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _simplePopup(
          list.EquipoCapitanesModel entity, int keyId, BuildContext context) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Llamar por WhatsApp al Capitán"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Inscribirse a un equipo"),
          ),
          PopupMenuItem(
            value: 3,
            child: Text("Salirme de mi equipo"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              callWhatsAppText(int.parse(entity.telefono),
                  'Capitan del equipo ${entity.nombre}, deseo formar parte de su equipo mando mi solictud para que sea evaluada por su persona. Saludos.');
              break;
            case 2:
              loadingEntity(entity);

              break;

            case 3:
              loadingUpdateEntity(
                  2, int.parse(prefs.idPlayer), entity.idEquipo);

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

  Widget _showListTile(list.EquipoCapitanesModel entity) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            sizedBox(0, 7),
            CardVM(
              size: 215,
              imageAssets: 'assets/icono3.png',
              opciones: _simplePopup(entity, entity.agrupador, context),
              listWidgets: [
                avatarCircleTransparent(entity.foto, 55),
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
                Text(
                  'CAPITAN: ${entity.jugadorCapitan}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'PSDN : ${entity.psdn}',
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

  void loadingEntity(list.EquipoCapitanesModel entity) {
    entityModel.states = StateEntity.Insert;
    entityModel.idEquipo = 0;
    entityModel.idJugador = int.parse(prefs.idPlayer);
    entityModel.nombre = entity.nombre;
    entityModel.detalle = entity.detalle;
    entityModel.foto = entity.foto;
    entityModel.usuarioAuditoria = prefs.email;
    entityModel.agrupador = entity.agrupador;
    entityModel.esCapitan = 0;

    executeCUD(entityService, entityModel);
  }

  void loadingUpdateEntity(int estado, int idJugador, int idEquipo) {
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
        
        if (result["tipo_mensaje"] == '0')
          showSnackbar(
              'Su solictud para salirse del equipo fue enviado con éxito!',
              scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }

  void executeCUD(
      EquipmentService entityService, model.EquipoModel entity) async {
    try {
      await entityService.repository(entity).then((result) {
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }

  void executeDelete(String id, String usuario) async {
    try {
      await entityService.delete(id, usuario).then((result) {
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
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
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
} // FIN DE LA CLASE
