import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/MultimediaModel.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/service/MultimediaService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
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
  MultimediaService entityService = new MultimediaService();
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
    // entityService = Provider.of<MultimediaService>(context);

    return Scaffold(
      key: scaffoldKey,
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
                      'GESTIONA GALERIA MULTIMEDIA',
                      'En esta pantalla puedes modificar y eliminar las galerias multimedia que haz creado anteriormente.',
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
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
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
        CardVM(
          size: 135,
          imageAssets: 'assets/icono3.png',
          opciones: _simplePopup(entity, entity.idMultimedia.toString()),
          accesosRapidos: null,
          listWidgets: [
            Text('Titulo: ${entity.titulo}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'DETALLE: ${entity.resumen}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'ENLACE: ${entity.enlace}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'NOTICIA/EVENTO: ${entity.idaCategoria}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'FECHA INICIO: ${entity.fechainicio}',
                  style: kSubtitleStyleWhite,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'FECHA FIN     :  ${entity.fechafin}',
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

  Widget _simplePopup(MultimediaModel entity, String keyId) =>
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
              showSnackbarWithOutKey("Metodo por implementar", context);
              break;
            case 2:
              entityModel.idMultimedia = int.parse(keyId);
              print('eliminar ${entityModel.idMultimedia}');

              setState(() {
                executeDelete(entityModel.idMultimedia.toString(), prefs.email);
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

  void executeDelete(String id, String usuario) {
    try {
      entityService.delete(id, usuario).then((result) {
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
