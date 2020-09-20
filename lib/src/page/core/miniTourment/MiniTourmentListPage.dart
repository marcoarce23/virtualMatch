import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ClasificadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model;
import 'package:virtual_match/src/model/entity/EntityMap/TorneoModelo.dart'
    as model;

class MiniTourmentListPage extends StatefulWidget {
  static final String routeName = 'MiniTtourmentList';
  MiniTourmentListPage({Key key}) : super(key: key);

  @override
  _MiniTourmentListPageState createState() => _MiniTourmentListPageState();
}

class _MiniTourmentListPageState extends State<MiniTourmentListPage> {
  //DEFINICION DE BLOC Y MODEL
  ListaTorneoModel entity = new ListaTorneoModel();
  model.TorneoModel entityModel = new model.TorneoModel();
  TourmentService entityService;
  TourmentService entityGet = TourmentService();
  PlayerService entityGet1 = PlayerService();
  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _save = false;
  String _opcionJugador = '1';

  @override
  void initState() {
    prefs.lastPage = MiniTourmentListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        future: entityGet.get(new ListaTorneoModel()),
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
          ListaTorneoModel entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(ListaTorneoModel entity) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        sizedBox(0, 7.0),
        /*
        Container(
          width: size.width * 0.95,
          margin: EdgeInsets.symmetric(vertical: 0.0),
          decoration: boxDecoration(),
          child: Column(
            children: <Widget>[
              gfListTileKey(
                  Key(entity.idTorneo.toString()),
                  Text(
                    'TÍTULO : ${entity.nombreTorneo}',
                    style: TextStyle(
                      color: AppTheme.themeWhite,
                    ),
                  ),
                  Text('DETALLE: ${entity.detalle}',
                      style: TextStyle(color: AppTheme.themeWhite)),
                  _showAction(entity, entity.idTorneo.toString()),
                  null,
                  null, //avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
                  EdgeInsets.all(0.0),
                  EdgeInsets.all(0.0)),
            ],
          ),
        ),
        */
        CardVM(
          size: 100,
          imageAssets: 'assets/icono3.png',
          opciones: _simplePopup(entity, entity.idTorneo.toString()),
          accesosRapidos: null,
          listWidgets: [
            Text(
              'TÍTULO : ${entity.nombreTorneo}',
              style: TextStyle(
                color: AppTheme.themeWhite,
              ),
            ),
            Text('DETALLE: ${entity.detalle}',
                style: TextStyle(color: AppTheme.themeWhite)),
          ],
        ),
      ],
    );
    //Text(entity.nombreEquipo);
  }

  Widget _simplePopup(ListaTorneoModel entity, String keyId) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Agregar participantes"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Empezar el torneo"),
          ),
          PopupMenuItem(
            value: 3,
            child: Text("Editar"),
          ),
          PopupMenuItem(
            value: 4,
            child: Text("Eliminar"),
          ),
        ],
        onCanceled: () {},
        onSelected: (value) {
          switch (value) {
            case 1:
              setState(() {
                _showPlayer();
              });

              break;
            case 2:
              _start(keyId, entity.idTipoModalidad.toString());
              break;
            case 3:
              entityModel.states = StateEntity.Update;
              entityModel.usuarioAuditoria = prefs.email;
              showSnackbarWithOutKey("Metodo por implementar", context);
              break;
            case 4:
              entityModel.states = StateEntity.Delete;
              entityModel.usuarioAuditoria = prefs.email;
              showSnackbarWithOutKey("Metodo por implementar", context);
              break;
            default:
              showSnackbarWithOutKey("No hay opcion seleccionada", context);
              break;
          }
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
          size: 30,
        ),
        offset: Offset(0, 100),
      );

  _showPlayer() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Selecionar Jugadores'),
                _comboJugador(),
                _button('Guardar', 18.0, 20.0),
              ],
            ),
            // actions: [
            //   MaterialButton(
            //     child: Text('Agregar'),
            //      onPressed: () {}),
            // ],
          );
        });
  }

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      ClasificadorModel item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.idClasificador.toString(),
      ));
    }
    return lista;
  }

  Widget _comboJugador() {
    return Center(
        child: FutureBuilder(
            future: entityGet1.get(new model.JugadorModel()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    sizedBox(15.0, 0),
                    // Text('Tipo Moldalidad'),
                    sizedBox(15.0, 0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themePurple),
                      value: _opcionJugador,
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionJugador = value;
                        });
                      },
                    ),
                  ],
                );
              } else {
                return loading();
              }
            }));
  }

  Widget _button(String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeDefault,
      icon: FaIcon(FontAwesomeIcons.checkCircle, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: (_save) ? null : _submit,
    );
  }

  _submit() async {
    setState(() => _save = true);
    // executeCUD(entityService, entity);
    setState(() => _save = false);
  }

  void executeCUD() async {
    // try {
    //   await entityService.repository(entity).then((result) {
    //     print('EL RESULTTTTT: ${result["tipo_mensaje"]}');

    //     if (result["tipo_mensaje"] == '0') {
    //       showSnackbar(STATUS_OK, scaffoldKey);

    //       // navigation(
    //       //   context, TourmentListPage()
    //       // );

    //     } else
    //       showSnackbar(STATUS_ERROR, scaffoldKey);
    //   });
    // } catch (error) {
    //   showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    // }
    //  navegation(context, FormatLoadPage());
  }

  Widget _showAction(ListaTorneoModel entity, String keyId) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Text('OPERACIONES: $keyId',
                style: TextStyle(color: AppTheme.themeWhite)),
            sizedBox(10, 0),
            _update(),
            sizedBox(10, 0),
            _delete(keyId),
          ],
        ),
        sizedBox(0, 10),
        Row(
          children: [
            Text('$keyId', style: TextStyle(color: AppTheme.themeWhite)),
            sizedBox(10, 0),
            //    _complete(keyId),
            // sizedBox(10, 0),
            _start(keyId, entity.idTipoModalidad.toString()),
          ],
        ),
      ],
    );
  }

  _update() {
    entityModel.states = StateEntity.Update;
    entityModel.usuarioAuditoria = prefs.email;

    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.edit,
        color: AppTheme.themeWhite,
        size: 20,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }

  _delete(String keyId) {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.trashAlt,
        color: AppTheme.themeWhite,
        size: 20,
      ),
      onTap: () {
        setState(() {
          //    entityModel.idTorneo = int.parse(keyId);
          //     print('eliminar ${entityModel.idTorneo}');
          //      executeDelete(entityModel.idTorneo.toString(), prefs.email);
        });
      },
    );
  }

  _complete(String keyId) {
    return InkWell(
      //  key: Key(keyId),
      child: FaIcon(
        FontAwesomeIcons.users,
        color: AppTheme.themeWhite,
        size: 20,
      ),
      onTap: () {
        setState(() {
          //    entityModel.idTorneo = int.parse(keyId);
          //     print('eliminar ${entityModel.idTorneo}');
          //      executeDelete(entityModel.idTorneo.toString(), prefs.email);
        });
      },
    );
  }

  _start(String keyId, String modalidad) {
    if (modalidad == '0')
      _executeGenerator('/api/Torneo/execGenerarPlayOff/' +
          keyId +
          '/usuario/' +
          prefs.email);
    else
      _executeGenerator('/api/Torneo/execGenerarLiga/usuario/' +
          keyId +
          '/usuario/' +
          prefs.email);
  }

  void executeDelete(String id, String usuario) async {
    try {
      await entityService
          .delete(
        id,
        usuario,
      )
          .then((result) {
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
      TourmentService entityService, model.TorneoModel entity) async {
    try {
      await entityService.repository(entity).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }

  void _executeGenerator(String url) async {
    try {
      await entityService.execute(API + url).then((result) {
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(
          'No puede generar porque aun no se completo la cantidad de jugadores inscritos !!',
          scaffoldKey);
    }
  }
} // FIN DE LA CLASE
// FIN DE LA CLASE
// FIN DE LA CLASE
