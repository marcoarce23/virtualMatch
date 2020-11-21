import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NoticiaEventoModel.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NewService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NoticiaEventoModel.dart'
    as model;

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
  NewService entityService = new NewService();
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
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('CREA NOTICIAS-EVENTOS'),
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
      floatingActionButton: floatButtonImage(Colors.transparent, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),
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
    return Column(
      children: <Widget>[
        sizedBox(0, 7.0),
        CardVM(
          size: 245,
          imageAssets: 'assets/icono3.png',
          opciones:
              _simplePopup(entity, entity.idNoticiaEvento.toString(), context),
          accesosRapidos: null,
          listWidgets: [
            avatarCircleTransparent(entity.foto, 40),
            sizedBox(0, 7),
            Text(
              'TÍTULO: ${entity.titulo}',
              style: kSubtitleStyleWhite,
              softWrap: true,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.justify,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'DETALLE: ${entity.objetivo}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'DIRIGIDO A: ${entity.dirigidoa}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'LIGAR/VIRTUAL: ${entity.dirigidoa}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'FECHA Y HORA: ${entity.fecha} ${entity.hora}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _simplePopup(
          NoticiaEventoModel entity, String keyId, BuildContext context) =>
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
              Navigator.pushNamed(context, 'new', arguments: entity);
              break;
            case 2:
              entityModel.idNoticiaEvento = int.parse(keyId);

              executeDelete(keyId, prefs.email);

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
      await entityService.delete(id, usuario).then((result) {
        if (result["tipo_mensaje"] == '0') {
          setState(() {
            showSnackbar(result["mensaje"], scaffoldKey);
          });
        } else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
    setState(() {});
  }
} // FIN DE LA CLASE
