import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/widget/util/Util.dart';
import 'TourmentPage.dart';

import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
//import 'package:virtual_match/src/model/entity/EntityMap/ListadoTorneoModel.dart'  as model;

class ListTournamentPage extends StatefulWidget {
  ListTournamentPage({Key key}) : super(key: key);
  static final String routeName = 'ListTournament';

  @override
  _ListTournamentPageState createState() => _ListTournamentPageState();
}

class _ListTournamentPageState extends State<ListTournamentPage> {
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TourmentService entityService = new TourmentService();
  ListaTorneoModel entity = new ListaTorneoModel();
  TourmentService entityGet = TourmentService();

// model.NotificacionModel entityModel = new model.NotificacionModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
        // return MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(builder: (_) => new CrudService()),
        //   ],
        //   child:

        Scaffold(
      key: scaffoldKey,
      //appBar: appBar('TORNEOS VIRTUAL MATCH'),
      body: SingleChildScrollView(child: bodyContainer(context)),
      //drawer: DrawerMenu(),
      //floatingActionButton: CircularMenu(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      //bottomNavigationBar: new BottonNavigation(),
      //   ),
    );
  }

  Widget bodyContainer(BuildContext context) {
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getTodosLosTorneos(new ListaTorneoModel()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return Column(
                children: <Widget>[
                  // Row(
                  //   children: <Widget>[
                  //     Shimmer.fromColors(
                  //       baseColor: AppTheme.themeDefault,
                  //       highlightColor: AppTheme.themePurple,
                  //       child: FaIcon(FontAwesomeIcons.playstation,
                  //           color: AppTheme.themeDefault, size: 35.0),
                  //     ),
                  //     AutoSizeText(
                  //       'Listado de torneos'.toUpperCase(),
                  //       style: kTitleStyleBlack,
                  //       softWrap: true,
                  //       overflow: TextOverflow.clip,
                  //       textAlign: TextAlign.justify,
                  //     ),
                  //   ],
                  // ),

                  sizedBox(0, 8.0),

                  showInformationBasic(
                    context,
                    'TORNEOS - VIRTUAL MATCH',
                    'Conoce los resultados actuales de los torneos de la comunidad.',
                  ),
                  sizedBox(0, 5.0),
                  dividerBlack(),
                  listView(context, snapshot),
                  //     copyRigthBlack(),
                ],
              );
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          ListaTorneoModel entity = snapshot.data[index];
          return showListTournament(context, entity);
        },
      ),
    );
  }

  Widget showListTournament(BuildContext context, ListaTorneoModel entity) {
    return Container(
      child: InkWell(
        onTap: () {
          if (entity.cantidadInscritos == entity.cantidadJugadores) {
            navegation(context, TourmentPage(idTorneo: entity.idTorneo));
          } else {
            showSnackbar(
                'Aun no se completo la cantidad de inscritos al torneo  ',
                scaffoldKey);
          }
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            //decoration: boxDecoration(),
            child: Column(
              children: <Widget>[
                SlideInUp(
                  duration: Duration(seconds: 1),
                  child: Stack(
                    children: [
                      gfListTile(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('TORNEO: ${entity.nombreTorneo}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppTheme.themeWhite)),
                              Text('TIPO:  ${entity.tipoCompeticion}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppTheme.themeWhite)),
                              Text(
                                  'INSCRITOS:  ${entity.cantidadInscritos}/${entity.cantidadJugadores}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppTheme.themeWhite)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Text('DETALLE:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: AppTheme.themeWhite)),
                              ),
                              sizedBox(5, 0),
                              Flexible(
                                flex: 5,
                                child: AutoSizeText(
                                  entity.detalle,
                                  style: kSubSubTitleCardStyle,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Flexible(flex: 3, child: Container())
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text('PREMIOS:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: AppTheme.themeWhite)),
                                      sizedBox(5, 0),
                                      Text(entity.premios,
                                          style: TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                ],
                              ),
                              AutoSizeText(
                                'Del ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)}',
                                style: kSubSubTitleCardStyle,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.justify,
                              ),
                              //_showAction(entity.idTorneo.toString()),
                            ],
                          ),
                          null, //FaIcon(FontAwesomeIcons.infoCircle),
                          null,
                          EdgeInsets.all(4.0),
                          EdgeInsets.all(4.0)),
                      Positioned(
                          left: MediaQuery.of(context).size.width * 0.72,
                          child: RadialProgress(
                              progressColor: AppTheme.themePurple,
                              child: avatarCircle(entity.foto, 55.0))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showAction(String keyId) {
    return Column(
      children: [
        sizedBox(5, 0),
        _detail(keyId),
        sizedBox(0, 6),
        Row(
          children: <Widget>[
            _subcription(keyId),
            sizedBox(5, 0),
            _delete(keyId),
          ],
        ),
      ],
    );
  }

  _subcription(String keyId) {
    //  entityModel.states = StateEntity.Update;
    // entityModel.usuarioAuditoria = prefs.email;

    return Row(
      children: [
        Text('Inscribirse: ', style: TextStyle(color: AppTheme.themeWhite)),
        InkWell(
          child: FaIcon(
            FontAwesomeIcons.handPointUp,
            color: AppTheme.themePurple,
            semanticLabel: 'Inscribirse',
            size: 27,
          ),
          onTap: () {
            setState(() {
              _executeInscription(keyId, prefs.idPlayer);
            });
          },
        ),
      ],
    );
  }

  _delete(String keyId) {
    return Row(
      children: [
        Text('Salirse: ', style: TextStyle(color: AppTheme.themeWhite)),
        InkWell(
          key: Key(keyId),
          child: FaIcon(
            FontAwesomeIcons.handPointDown,
            color: AppTheme.themePurple,
            size: 27,
          ),
          onTap: () {
            setState(() {
              // entityModel.idNotificacion = int.parse(keyId);
              // print('eliminar ${entityModel.idNotificacion}');
              _executeUnsuscription(keyId, prefs.idPlayer);
            });
          },
        ),
      ],
    );
  }

  _detail(String keyId) {
    return Row(
      children: [
        Text('VER DETALLE DEL TORNEO : ',
            style: TextStyle(color: AppTheme.themeWhite)),
        InkWell(
          //
          child: FaIcon(
            FontAwesomeIcons.commentDots,
            color: AppTheme.themePurple,
            size: 27,
          ),
          onTap: () {
            setState(() {
              _executeUnsuscription('1', '3');
            });
          },
        ),
      ],
    );
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

  void _executeUnsuscription(String idTorneo, String idJugador) async {
    print('ENTROSSSS $idTorneo y $idJugador');
    try {
      await entityService
          .execute(API +
              '/api/Torneo/Desinscribir/Torneo/' +
              idTorneo +
              '/Jugador/' +
              idJugador)
          .then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(result["mensaje"], scaffoldKey);
        if (result["tipo_mensaje"] == '2')
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar('El usuario ya salio del torneo!!', scaffoldKey);
    }
  }

  Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("First"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Second"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          print("value:$value");
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        offset: Offset(0, 100),
      );
}
