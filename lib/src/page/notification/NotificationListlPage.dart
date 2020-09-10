import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/notification/NotificationLoadPage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
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
          //  color: Colors.black87,
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
                      'ADMINISTRA LAS NOTIFICACIONES',
                      'En esta pantalla puedes modificar y eliminar las notificaciones que haz creado anteriormente.',
                    ),
                    sizedBox(0.0, 3),
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
        sizedBox(0, 7.0),
        Container(
          width: size.width * 0.95,
          margin: EdgeInsets.symmetric(vertical: 0.0),
          decoration: boxDecoration(),
          child: Column(
            children: <Widget>[
              gfListTileKey(
                  Key(entity.idNotificacion.toString()),
                  Text(
                    'TÍTULO : ${entity.titulo}',
                    style: TextStyle(
                      color: AppTheme.themeWhite,
                    ),
                  ),
                  Text('DETALLE: ${entity.detalle}',
                      style: TextStyle(color: AppTheme.themeWhite)),
                  _showAction(
                      entity, entity.idNotificacion.toString(), context),
                  null,
                  null, //avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
                  EdgeInsets.all(5.0),
                  EdgeInsets.all(3.0)),
            ],
          ),
        ),
      ],
    );
    //Text(entity.nombreEquipo);
  }

  Widget _showAction(
      NotificacionModel entity, String keyId, BuildContext context) {
    return Row(
      children: <Widget>[
        sizedBox(0, 15),
        Text('OPERACIONES: ', style: TextStyle(color: AppTheme.themeWhite)),
        sizedBox(10, 0),
        _update(context, entity),
        sizedBox(10, 0),
        _delete(keyId),
        sizedBox(10, 0),
        _notification(keyId),
      ],
    );
  }

  _update(BuildContext context, NotificacionModel entity) {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.edit,
        color: AppTheme.themePurple,
        size: 26,
      ),
      onTap: () {
        setState(() {
          Navigator.pushNamed(context, 'notificationLoad', arguments: entity);
        });
      },
      //  ),
    );
  }

  _delete(String keyId) {
    return InkWell(
      key: Key(keyId),
      child: FaIcon(
        FontAwesomeIcons.trashAlt,
        color: AppTheme.themePurple,
        size: 26,
      ),
      onTap: () {
        setState(() {
          entityModel.idNotificacion = int.parse(keyId);
          executeDelete(
            entityModel.idNotificacion.toString(),
            prefs.email,
          );
        });
      },
    );
  }

  _notification(String keyId) {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.bell,
        color: AppTheme.themePurple,
        size: 26,
      ),
      onTap: () {
        setState(() {
          //    entityModel.idNotificacion = int.parse(keyId);
          //   executeDelete(entityModel.idNotificacion.toString(), prefs.email);
        });
      },
    );
  }

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
