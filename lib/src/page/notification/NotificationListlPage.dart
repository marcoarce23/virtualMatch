import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/theme/Theme.dart';
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
  NotificationService entityService;
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
    entityService = Provider.of<NotificationService>(context);

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
                    _header(),
                    divider(),
                    sizedBox(0.0, 7.0),
                  ],
                ),
              ),
              futureBuilder(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatButton(AppTheme.themeDefault, context,
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

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(NotificacionModel entity) {
    return Container(
      child: gfListTileKey(
          Key(entity.idNotificacion.toString()),
          Text(entity.titulo),
          Text(entity.detalle),
          _showAction(entity, entity.idNotificacion.toString()),
          null,
          avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
          EdgeInsets.all(5.0),
          EdgeInsets.all(3.0)),
    );
    //Text(entity.nombreEquipo);
  }

  Widget _showAction(NotificacionModel entity, String keyId) {
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
        'NOTIFICACIÓN: Virtual Match',
        'Porque formas parte de la familia, te tenemos informado.',
        FaIcon(FontAwesomeIcons.infoCircle),
        avatarSquare(IMAGE_DEFAULT, 35.0),
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
          entityModel.idNotificacion = int.parse(keyId);
          print('eliminar ${entityModel.idNotificacion}');
          executeDelete(entityModel.idNotificacion.toString(), prefs.email);
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
      NotificationService entityService, model.NotificacionModel entity) async {
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
