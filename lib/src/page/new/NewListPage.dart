import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NoticiaEventoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/service/NewService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NoticiaEventoModel.dart'
    as model;
import 'package:virtual_match/src/widget/menu/CircularMenu.dart';

class NewListPage extends StatefulWidget {
  static final String routeName = 'notificationList';
  NewListPage({Key key}) : super(key: key);

  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  //DEFINICION DE BLOC Y MODEL
  NoticiaEventoModel entity = new NoticiaEventoModel();
  model.NoticiaEventoModel entityModel = new model.NoticiaEventoModel();
  NewService entityService;
  NewService entityGet = NewService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = NewListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // entityService = Provider.of<NewService>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('Virtual Match'.toUpperCase()),
      drawer: DrawerMenu(),
      bottomNavigationBar: new BottonNavigation(),
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      'GESTIONA LAS NOTICIAS Y EVENTOS',
                      'En esta pantalla puedes modificar y eliminar las notificaciones que haz creado anteriormente.',
                    ),
                    sizedBox(0.0, 5.0),
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
      floatingActionButton: new CircularMenu(),

      // floatButton(AppTheme.themeDefault, context,
      //   FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new NoticiaEventoModel()),
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
          NoticiaEventoModel entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(NoticiaEventoModel entity) {
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
                  Key(entity.idNoticiaEvento.toString()),
                  Text('Titulo: ${entity.titulo}'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Detalle: ${entity.objetivo}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Dirigo a: ${entity.dirigidoa}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Lugar/Virtual: ${entity.dirigidoa}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Fecha y Hora: ${entity.fecha} ${entity.hora}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  _showAction(entity, entity.idNoticiaEvento.toString()),
                  null,
                  avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
                  EdgeInsets.all(5.0),
                  EdgeInsets.all(3.0)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showAction(NoticiaEventoModel entity, String keyId) {
    return Row(
      children: <Widget>[
        Text(
          '$keyId',
          style: TextStyle(color: Colors.white),
        ),
        sizedBox(10, 0),
        _update(),
        sizedBox(10, 0),
        _delete(keyId),
        sizedBox(10, 0),
        _like(),
      ],
    );
  }

  _like() {
    entityModel.states = StateEntity.Update;
    entityModel.usuarioAuditoria = prefs.email;

    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.handPointUp,
        color: AppTheme.themePurple,
        size: 23,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }

  _update() {
    entityModel.states = StateEntity.Update;
    entityModel.usuarioAuditoria = prefs.email;

    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.commentDots,
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
        FontAwesomeIcons.smile,
        color: AppTheme.themePurple,
        size: 23,
      ),
      onTap: () {
        setState(() {
          entityModel.idNoticiaEvento = int.parse(keyId);
          print('eliminar ${entityModel.idNoticiaEvento}');
          executeDelete(entityModel.idNoticiaEvento.toString(), prefs.email);
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
      NewService entityService, model.NoticiaEventoModel entity) async {
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
