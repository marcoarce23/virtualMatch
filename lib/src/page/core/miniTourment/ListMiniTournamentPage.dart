import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/tourment/DateTournament.dart';
import 'package:virtual_match/src/page/core/tourment/TourmentPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class ListMiniTournamentPage extends StatefulWidget {
  static final String routeName = 'ListMiniTournament';

  @override
  _ListMiniTournamentPageState createState() => _ListMiniTournamentPageState();
}

class _ListMiniTournamentPageState extends State<ListMiniTournamentPage> {
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TourmentService entityService = new TourmentService();
  ListaTorneoModel entity = new ListaTorneoModel();
  TourmentService entityGet = TourmentService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('MIS TORNEOS VIRTUAL MATCH'),
      body: SingleChildScrollView(
          child: Container(
             // height: size.height,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/portada2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: bodyContainer(context))),
      drawer: DrawerMenu(),
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
       bottomNavigationBar: new BottonNavigation(),

      //   ),
    );
  }

  Widget bodyContainer(BuildContext context) {
    sizedBox(0, 7);
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getTodosLosTorneos(new ListaTorneoModel(), -1),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return Column(
                children: <Widget>[
                  showInformationBasic(
                    context,
                    'MIS TORNEOS - VIRTUAL MATCH',
                    'Conoce los resultados actuales de tus torneos.',
                  ),
                  sizedBox(0, 5.0),
                  divider(),
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
    return Column(
      children: <Widget>[
        CardVM(
          size: 170,
          imageAssets: 'assets/icono3.png',
          opciones: _simplePopup(entity.idTorneo.toString()),
          accesosRapidos: null,
          listWidgets: [
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
            Text('DETALLE:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppTheme.themeWhite)),
            AutoSizeText(
              entity.detalle,
              style: kSubSubTitleCardStyle,
              softWrap: true,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.justify,
            ),
            Text('PREMIOS:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppTheme.themeWhite)),
            Text(entity.premios, style: TextStyle(fontSize: 13)),
            AutoSizeText(
              'Fecha: ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)}',
              style: kSubSubTitleCardStyle,
              softWrap: true,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ],
    );
  }

  Widget _simplePopup(String idTorneo) => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Fechas de torneo"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Ver detalle"),
          ),
          PopupMenuItem(
            value: 3,
            child: Text("Inscribirse al torneo"),
          ),
          PopupMenuItem(
            value: 4,
            child: Text("Salir del torneo"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              navegation(
                  context,
                  DateTournament(
                    idTorneo: int.parse(idTorneo),
                    idJugador: prefs.idJugador,
                  ));
              break;

            case 2:
              _detail(idTorneo);
              break;
            case 3:
              _subcription(idTorneo);
              break;
            case 4:
              _delete(idTorneo);
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

  _detail(String keyId) {
    if (entity.cantidadInscritos == entity.cantidadJugadores) {
      navegation(context, TourmentPage(idTorneo: int.parse(keyId)));
    } else {
      showSnackbar('Aun no se completo la cantidad de inscritos al torneo  ',
          scaffoldKey);
    }
  }

  _subcription(String keyId) {
    //  entityModel.states = StateEntity.Update;
    // entityModel.usuarioAuditoria = prefs.email;

    return _executeInscription(keyId, prefs.idPlayer);
  }

  _delete(String keyId) {
    return _executeUnsuscription(keyId, prefs.idPlayer);
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
}
