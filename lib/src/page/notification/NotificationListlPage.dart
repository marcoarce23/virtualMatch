import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NotificacionModel.dart'
    as model;

class NotificationListPage extends StatefulWidget {
  static final String routeName = 'notificationList';
  NotificationListPage({Key key}) : super(key: key);

  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  //DEFINICION DE BLOC Y MODEL
  NotificacionModel entity = new NotificacionModel();
  model.NotificacionModel entityModel = new model.NotificacionModel();
  NotificationService entityService = NotificationService();
  NotificationService entityGet = NotificationService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = NotificationListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //  entityService = Provider.of<NotificationService>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('NOTIFICACIONES'),
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
              //  backgroundBasic(context),
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    sizedBox(0.0, 8),
                    showInformationBasic(
                      context,
                      'ADMINISTRA LAS NOTIFICACIONES',
                      'En esta pantalla puedes modificar y eliminar las notificaciones que haz creado anteriormente.',
                    ),
                    sizedBox(0.0, 3),
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
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            sizedBox(0, 7),
            CardVM(
              size: 90,
              imageAssets: 'assets/icono3.png',
              opciones: _simplePopup(
                  entity, entity.idNotificacion.toString(), context),
              accesosRapidos: null,
              listWidgets: [
                Text(
                  'TÍTULO : ${entity.titulo}',
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
    //Text(entity.nombreEquipo);
  }

  Widget _simplePopup(
          NotificacionModel entity, String keyId, BuildContext context) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Notificar"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Editar"),
          ),
          PopupMenuItem(
            value: 3,
            child: Text("Eliminar"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              showSnackbarWithOutKey("Por implementar", context);
              break;
            case 2:
              Navigator.pushNamed(context, 'notificationLoad',
                  arguments: entity);
              break;
            case 3:
              entityModel.idNotificacion = int.parse(keyId);

              setState(() {
                executeDelete(
                  entityModel.idNotificacion.toString(),
                  prefs.email,
                );
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

  void executeDelete(String id, String usuario) async {
    try {
      entityService.delete(id, usuario).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0') {
          showSnackbar(STATUS_OK, scaffoldKey);
          //   futureBuilder(context);
        } else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
} // FIN DE LA CLASE
