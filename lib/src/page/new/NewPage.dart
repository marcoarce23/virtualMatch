import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NoticiaEventoModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NewService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NoticiaEventoModel.dart'
    as model;

class NewPage extends StatefulWidget {
  static final String routeName = 'notificationList';
  NewPage({Key key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  //DEFINICION DE BLOC Y MODEL
  NoticiaEventoModel entity = new NoticiaEventoModel();
  model.NoticiaEventoModel entityModel = new model.NoticiaEventoModel();
  NewService entityService = new NewService();
  NewService entityGet = NewService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = NewPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // entityService = Provider.of<NewService>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('CONOCE A LA COMUNIDAD'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          //  color: Colors.black87,
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
                      'CONOCE A NUESTROS JUGADORES',
                      'Busca y comunicate con los jugadores.',
                    ),
                    sizedBox(0.0, 2.0),
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
          FaIcon(FontAwesomeIcons.futbol), HomePage()),

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
                        '${entity.objetivo}',
                        style: TextStyle(color: AppTheme.themeWhite),
                      ),
                      Text(
                        'Departamento: ${entity.dirigidoa}',
                        style: TextStyle(color: AppTheme.themeWhite),
                      ),
                    ],
                  ),
                  _showAction(
                      entity, entity.idNoticiaEvento.toString(), context),
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

  Widget _showAction(
      NoticiaEventoModel entity, String keyId, BuildContext context) {
    return Row(
      children: <Widget>[
        sizedBox(0, 15),
        Text('COMUNICATE POR: $keyId',
            style: TextStyle(color: AppTheme.themeWhite)),
        sizedBox(10, 0),
        _update(context, entity),
        sizedBox(10, 0),
        _delete(keyId),
        sizedBox(10, 0),
        _email(),
      ],
    );
  }

  _update(BuildContext context, NoticiaEventoModel entity) {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.phone,
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
        FontAwesomeIcons.whatsapp,
        color: AppTheme.themePurple,
        size: 26,
      ),
      onTap: () {
        setState(() {
          entityModel.idNoticiaEvento = int.parse(keyId);
          executeDelete(keyId, prefs.email);
        });
      },
    );
  }

  _email() {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.exchangeAlt,
        color: AppTheme.themePurple,
        size: 26,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }

  void executeDelete(String id, String usuario) {
    try {
      entityService.delete(id, usuario).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');

        if (result["tipo_mensaje"] == '0') {
          showSnackbar(STATUS_OK, scaffoldKey);
        } else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
} // FIN DE LA CLASE
