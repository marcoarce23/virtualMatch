import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/MultimediaModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/service/MultimediaService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/MultimediaModel.dart'
    as model;

class MultimediaListPage extends StatefulWidget {
  static final String routeName = 'multimediaList';
  MultimediaListPage({Key key}) : super(key: key);

  @override
  _MultimediaListPageState createState() => _MultimediaListPageState();
}

class _MultimediaListPageState extends State<MultimediaListPage> {
  //DEFINICION DE BLOC Y MODEL
  MultimediaModel entity = new MultimediaModel();
  model.MultimediaModel entityModel = new model.MultimediaModel();
  MultimediaService entityService;
  MultimediaService entityGet = MultimediaService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = MultimediaListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    entityService = Provider.of<MultimediaService>(context);

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
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
                        'GESTIONA GALERIA MULTIMEDIA',
                        'En esta pantalla puedes modificar y eliminar las galerias multimedia que haz creado anteriormente.',),
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
      floatingActionButton: floatButton(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new MultimediaModel()),
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
          MultimediaModel entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(MultimediaModel entity) {
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
                  Key(entity.idMultimedia.toString()),
                  Text('Titulo: ${entity.titulo}'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Detalle: ${entity.resumen}',),
                      Text('Enlace: ${entity.enlace}'),
                      Text('Noticia/Evento: ${entity.idaCategoria}'),
                      Text('Fecha Inicio: ${entity.fechainicio}'),
                      Text('Fecha Fin     :  ${entity.fechafin}'),
                    ],
                  ),
                  _showAction(entity, entity.idMultimedia.toString()),
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

  Widget _showAction(MultimediaModel entity, String keyId) {
    sizedBox(0, 10.0);
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
          entityModel.idMultimedia = int.parse(keyId);
          print('eliminar ${entityModel.idMultimedia}');
          executeDelete(entityModel.idMultimedia.toString(), prefs.email);
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
      MultimediaService entityService, model.MultimediaModel entity) async {
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
