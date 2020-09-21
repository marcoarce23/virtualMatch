import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/TorneoModelo.dart'
    as model;
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model1;

class TourmentListPage extends StatefulWidget {
  static final String routeName = 'tourmentList';
  TourmentListPage({Key key}) : super(key: key);

  @override
  _TourmentListPageState createState() => _TourmentListPageState();
}

class _TourmentListPageState extends State<TourmentListPage> {
  //DEFINICION DE BLOC Y MODEL
  ListaTorneoModel entity = new ListaTorneoModel();
  model.TorneoModel entityModel = new model.TorneoModel();
  TourmentService entityService = new TourmentService();
  TourmentService entityGet = new TourmentService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _save = false;
  String _opcionJugador = '1';
  PlayerService entityGet1 = PlayerService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //  entityService = Provider.of<TourmentService>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('CREACIÓN DEL TORNEO'),
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
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    sizedBox(0.0, 8),
                    showInformationBasic(
                      context,
                      'INICIA EL TORNEO VIRTUAL MATCH',
                      'En esta pantalla puedes iniciar el torneo y agregar personas que faltantes.',
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
        future: entityGet.get(new ListaTorneoModel(), 1),
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
    print('ddddd: ${entity.idTorneo.toString()}');

    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            CardVM(
              size: 100,
              imageAssets: 'assets/icono3.png',
              opciones: _simplePopup(entity.idTorneo.toString(),
                  entity.idTipoCompeticion.toString()),
              accesosRapidos: null,
              listWidgets: [
                Text(
                  'ID TOREO : ${entity.idTorneo.toString()}',
                  style: TextStyle(
                    color: AppTheme.themeWhite,
                  ),
                ),
                Text(
                  'TÍTULO : ${entity.nombreTorneo}',
                  style: TextStyle(
                    color: AppTheme.themeWhite,
                  ),
                ),
                Text(
                  'TIPO: ${entity.tipoCompeticion}',
                  style: TextStyle(
                    color: AppTheme.themeWhite,
                  ),
                ),
                Text('DETALLE: ${entity.detalle}',
                    style: TextStyle(color: AppTheme.themeWhite)),
              ],
            ),
          ],
        ),
      ],
    );
    //Text(entity.nombreEquipo);
  }

  _update() {
    entityModel.states = StateEntity.Update;
    entityModel.usuarioAuditoria = prefs.email;

    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.edit,
        color: AppTheme.themePurple,
        size: 25,
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
        color: AppTheme.themePurple,
        size: 25,
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
    return Row(
      children: [
        Text('Agregar:', style: TextStyle(color: AppTheme.themeWhite)),
        sizedBox(10, 0),
        InkWell(
          //  key: Key(keyId),
          child: FaIcon(
            FontAwesomeIcons.users,
            color: AppTheme.themePurple,
            size: 25,
          ),
          onTap: () {
            setState(() {
              //    entityModel.idTorneo = int.parse(keyId);
              //     print('eliminar ${entityModel.idTorneo}');
              //      executeDelete(entityModel.idTorneo.toString(), prefs.email);
            });
          },
        ),
      ],
    );
  }

  void generateTournament(String tipoCompetencia, String keyId) {
    if (tipoCompetencia == '27')
      _executeGenerator('/api/Torneo/execGenerarPlayOff/' +
          keyId +
          '/usuario/' +
          prefs.email);
    else
      _executeGenerator(
          '/api/Torneo/execGenerarLiga/' + keyId + '/usuario/' + prefs.email);
  }

  void executeDelete(String id, String usuario) async {
    // try {
    //   await entityService.delete(id, usuario, prefs.email).then((result) {
    //     print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
    //     if (result["tipo_mensaje"] == '0')
    //       showSnackbar(STATUS_OK, scaffoldKey);
    //     else
    //       showSnackbar(STATUS_ERROR, scaffoldKey);
    //   });
    // } catch (error) {
    //   showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    // }
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

  _executeGenerator(String url) {
    try {
      entityService.execute(API + url).then((result) {
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        if (result["tipo_mensaje"] == '3')
          showSnackbar(result["mensaje"], scaffoldKey);
        if (result["tipo_mensaje"] == '2')
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar('El torneo ya se ha iniciado.!!! ', scaffoldKey);
    }
  }

  Widget _simplePopup(String idTorneo, String idTipoCompeticion) =>
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
          PopupMenuItem(
            value: 3,
            child: Text("Adicionar jugadores"),
          ),
          PopupMenuItem(
            value: 4,
            child: Text("Iniciar el torneo"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              print('Editar');
              //_update();
              break;
            case 2:
              print('Eliminar');
              //_delete(idTorneo);
              break;
            case 3:
              print('Adicionar jugadores');

              _showPlayer(idTorneo);

              //  _complete(idTorneo);
              break;
            case 4:
              print('Empezar torneo');
              generateTournament(idTipoCompeticion, idTorneo);
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

  _showPlayer(String idTorneo) {
    print('vvvvv $idTorneo');
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Selecionar Jugadores'),

                _comboJugador(),
                //   _button('Guardar', 18.0, 20.0, idTorneo),
              ],
            ),
            actions: [
              MaterialButton(
                  child: Text('Agregar'),
                  onPressed: () {
                    setState(() {
                      _executeInscription(idTorneo, _opcionJugador);
                    });
                  }),
            ],
          );
        });
  }

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      JugadorModel item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.idPsdn + ' - ' + item.nombre + ' ' + item.apellido),
        value: item.idJugador.toString(),
      ));
    }
    return lista;
  }

  Widget _comboJugador() {
    return Center(
        child: FutureBuilder(
            future: entityGet1.get(new model1.JugadorModel()),
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
                          print('valorrr: $_opcionJugador');
                          // _showPlayer('2');
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

  Widget _button(
      String text, double fontSize, double edgeInsets, String idTorneo) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeDefault,
      icon: FaIcon(FontAwesomeIcons.checkCircle, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: () =>
          _executeInscription(entity.idTorneo.toString(), _opcionJugador),
    );
  }

  _submit(String idTorneo) {
    setState(() => _save = true);
    _executeInscription(entity.idTorneo.toString(), _opcionJugador);
    setState(() => _save = false);
  }

  void _executeInscription(String idTorneo, String idJugador) async {
    print('ENTROSSSS $idTorneo y $idJugador');
    String respuesta;
    String mensaje;
    try {
      await entityService
          .execute(API +
              '/api/Torneo/Inscribir/Torneo/' +
              idTorneo +
              '/Jugador/' +
              idJugador)
          .then((result) {
        respuesta = result["tipo_mensaje"].toString();
        mensaje = result["mensaje"].toString();
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');

        if (respuesta == '0') showSnackbar(mensaje, scaffoldKey);
        if (respuesta == '2') showSnackbar(mensaje, scaffoldKey);
      });
    } catch (error) {
      showSnackbar('Usuario registrado !!!', scaffoldKey);
    }
  }
} // FIN DE LA CLASE
