import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model;
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/miniTourment/MiniTourmentListPage.dart';
import 'package:virtual_match/src/page/core/tourment/TourmentListPage.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';

import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SenWidget.dart';
import 'package:virtual_match/src/widget/general/SharedWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NoticiaEventoModel.dart'
    as model;
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model1;

class PlayerSelectionPage extends StatefulWidget {
  static final String routeName = 'playerSelection';
  final int idTorneo;
  final String torneo;
  final String competicion;
  final String modalidad;

  PlayerSelectionPage(
      {Key key,
      @required this.idTorneo,
      @required this.torneo,
      @required this.competicion,
      @required this.modalidad})
      : super(key: key);

  @override
  _PlayerSelectionPageState createState() => _PlayerSelectionPageState();
}

class _PlayerSelectionPageState extends State<PlayerSelectionPage> {
  //DEFINICION DE BLOC Y MODEL
  JugadorModelList entity = new JugadorModelList();
  model.JugadorModel entityModel = new model.JugadorModel();
  PlayerService entityGet = PlayerService();
  PlayerService entityGet1 = PlayerService();
  TourmentService entityService = new TourmentService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _opcionJugador = '1' + '|' + '71298852';
  //String _valorText;

  @override
  void initState() {
    prefs.lastPage = PlayerSelectionPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('AGREGAR PARTICIPANTES'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
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
                alignment: Alignment.center,
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    showInformation(
                      context,
                      'TORNEO:  ${widget.torneo}',
                      'COMPETICIÓN:  ${widget.competicion}',
                      'MODALIDAD:  ${widget.modalidad}',
                      'Busca y cos jugadores.',
                      'Busca y co los jugadores.',
                    ),
                    sizedBox(0.0, 2.0),
                    divider(),
                  ],
                ),
              ),
              sizedBox(0.0, 8.0),
              Center(
                child: Image(
                  image: NetworkImage(IMAGE_SCREEN3),
                  height: 180.0,
                  fit: BoxFit.fill,
                ),
              ),
              sizedBox(0, 15.0),
              Shimmer.fromColors(
                  baseColor: AppTheme.themeWhite,
                  highlightColor: AppTheme.themePurple,
                  child: Text('Selecciona a un jugador'.toUpperCase(),
                      style:
                          TextStyle(color: AppTheme.themeWhite, fontSize: 19))),
              sizedBox(0.0, 13.0),
              _comboJugador(),
              sizedBox(20.0, 20.0),
              _showAction(),
              //    futureBuilder(context),
              sizedBox(0.0, 8.0),
              copyRigth(),
            ],
          ),
        ),
      ),
      //  ),
      floatingActionButton: floatButton(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.arrowLeft), MiniTourmentListPage()),

      // floatButton(AppTheme.themeDefault, context,
      //   FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget _showAction() {
    final list = _opcionJugador.split('|');
    var numero = list[1].toString().trim();
    var idJugador = list[0].toString().trim();
    return Column(
      children: <Widget>[
        Row(
          children: [
            sizedBox(10, 0),
            sizedBox(15, 0),
            _call(numero),
            sizedBox(15, 0),
            _sms(numero),
            sizedBox(15, 0),
            _whatsapp(numero),
            sizedBox(15, 0),
            _shared(),
            sizedBox(15, 0),
            _add(idJugador),
          ],
        ),
        sizedBox(0, 10),
      ],
    );
  }

  _call(String numero) {
    return Row(
      children: [
        Text('Llamar'),
        InkWell(
          onTap: () {
            callNumber(int.parse(numero));
          },
          child: FaIcon(FontAwesomeIcons.phoneSquare,
              color: Colors.white, size: 32),
        ),
      ],
    );
  }

  _sms(String numero) {
    return InkWell(
      onTap: () {
        sendSMS(int.parse(numero));
      },
      child: FaIcon(FontAwesomeIcons.sms, color: Colors.white, size: 35),
    );
  }

  _shared() {
    return InkWell(
      onTap: () {
        sharedText(
            'BIENVENIDO A LA COMUNIDAD',
            '*Virtual Match.*\n , Te invitamos a jugar en el \n 🔺 *Torneo:* ${widget.torneo} \n 🔺 *Competición:* ${widget.competicion}\n 🔺 *Modalidad :* ${widget.modalidad}',
            'text/html');
      },
      child: FaIcon(FontAwesomeIcons.shareAlt, color: Colors.white, size: 31),
    );
  }

  _whatsapp(String numero) {
    return InkWell(
      onTap: () {
        callWhatsAppText(int.parse(numero),
            '*Virtual Match* \n 💬 Hola Fifero:\n, Te invitamos a jugar en el \n 🔺*Torneo:* ${widget.torneo} \n 🔺*Competición:* ${widget.competicion}\n 🔺*Modalidad :* ${widget.modalidad}');
      },
      child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 35),
    );
  }

  _add(String idJugador) {
    return InkWell(
        onTap: () {
          setState(() {
            _executeInscription(widget.idTorneo.toString(), idJugador);
          });
        },
        child: Shimmer.fromColors(
          baseColor: AppTheme.themeWhite,
          highlightColor: AppTheme.themePurple,
          child: FaIcon(FontAwesomeIcons.users, color: Colors.white, size: 33),
        ));
  }

  _executeInscription(String idTorneo, String idJugador) async {
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
        print('EL RESULTTTTTAAA: ${result["tipo_mensaje"]}');

        if (respuesta == '0') showSnackbar(mensaje, scaffoldKey);
        if (respuesta == '2') showSnackbar(mensaje, scaffoldKey);
      });
    } catch (error) {
      showSnackbar('Usuario registrado !!!', scaffoldKey);
    }
  }

  Widget _comboJugador() {
    return Center(
        child: FutureBuilder(
            future: entityGet1.get(new model1.JugadorModelPersonalizado()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    sizedBox(15.0, 0),
                    sizedBox(15.0, 0),
                    DropdownButton(
                      isExpanded: false,
                      dropdownColor: AppTheme.themePurple,
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

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      JugadorModelPersonalizado item = snapshot.data[i];
      lista.add(DropdownMenuItem(
          child: Text(
              item.telefono +
                  ' - ' +
                  item.idPsdn +
                  '\n - ' +
                  item.nombre +
                  ' ' +
                  item.apellido,
              style: TextStyle(color: AppTheme.themeWhite)),
          value: item.idJugador.toString() + '|' + item.telefono));
    }
    return lista;
  }
}

class PlayerSelectionVMPage extends StatefulWidget {
  static final String routeName = 'playerSelection';
  final int idTorneo;
  final String torneo;
  final String competicion;
  final String modalidad;

  PlayerSelectionVMPage(
      {Key key,
      @required this.idTorneo,
      @required this.torneo,
      @required this.competicion,
      @required this.modalidad})
      : super(key: key);

  @override
  _PlayerSelectionVMPageState createState() => _PlayerSelectionVMPageState();
}

class _PlayerSelectionVMPageState extends State<PlayerSelectionVMPage> {
  //DEFINICION DE BLOC Y MODEL
  JugadorModelList entity = new JugadorModelList();
  model.JugadorModel entityModel = new model.JugadorModel();
  PlayerService entityGet = PlayerService();
  PlayerService entityGet1 = PlayerService();
  TourmentService entityService = new TourmentService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _opcionJugador = '1' + '|' + '71298852';
  //String _valorText;

  @override
  void initState() {
    prefs.lastPage = PlayerSelectionPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('AGREGAR PARTICIPANTES'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
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
                alignment: Alignment.center,
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    showInformation(
                      context,
                      'TORNEO:  ${widget.torneo}',
                      'COMPETICIÓN:  ${widget.competicion}',
                      'MODALIDAD:  ${widget.modalidad}',
                      'Busca y cos jugadores.',
                      'Busca y co los jugadores.',
                    ),
                    sizedBox(0.0, 2.0),
                    divider(),
                  ],
                ),
              ),
              sizedBox(0.0, 8.0),
              Center(
                child: Image(
                  image: NetworkImage(IMAGE_SCREEN3),
                  height: 180.0,
                  fit: BoxFit.fill,
                ),
              ),
              sizedBox(0, 15.0),
              Shimmer.fromColors(
                  baseColor: AppTheme.themeWhite,
                  highlightColor: AppTheme.themePurple,
                  child: Text('Selecciona a un jugador'.toUpperCase(),
                      style:
                          TextStyle(color: AppTheme.themeWhite, fontSize: 19))),
              sizedBox(0.0, 13.0),
              _comboJugador(),
              sizedBox(20.0, 20.0),
              _showAction(),
              //    futureBuilder(context),
              sizedBox(0.0, 8.0),
              copyRigth(),
            ],
          ),
        ),
      ),
      //  ),
      floatingActionButton: floatButton(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.arrowLeft), TourmentListPage()),

      // floatButton(AppTheme.themeDefault, context,
      //   FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget _showAction() {
    final list = _opcionJugador.split('|');
    var numero = list[1].toString().trim();
    var idJugador = list[0].toString().trim();
    return Column(
      children: <Widget>[
        Row(
          children: [
            sizedBox(10, 0),
            sizedBox(15, 0),
            _call(numero),
            sizedBox(15, 0),
            _sms(numero),
            sizedBox(15, 0),
            _whatsapp(numero),
            sizedBox(15, 0),
            _shared(),
            sizedBox(15, 0),
            _add(idJugador),
          ],
        ),
        sizedBox(0, 10),
      ],
    );
  }

  _call(String numero) {
    return Row(
      children: [
        Text('Llamar'),
        InkWell(
          onTap: () {
            callNumber(int.parse(numero));
          },
          child: FaIcon(FontAwesomeIcons.phoneSquare,
              color: Colors.white, size: 32),
        ),
      ],
    );
  }

  _sms(String numero) {
    return InkWell(
      onTap: () {
        sendSMS(int.parse(numero));
      },
      child: FaIcon(FontAwesomeIcons.sms, color: Colors.white, size: 35),
    );
  }

  _shared() {
    return InkWell(
      onTap: () {
        sharedText(
            'BIENVENIDO A LA COMUNIDAD',
            '*Virtual Match.*\n , Te invitamos a jugar en el \n 🔺 *Torneo:* ${widget.torneo} \n 🔺 *Competición:* ${widget.competicion}\n 🔺 *Modalidad :* ${widget.modalidad}',
            'text/html');
      },
      child: FaIcon(FontAwesomeIcons.shareAlt, color: Colors.white, size: 31),
    );
  }

  _whatsapp(String numero) {
    return InkWell(
      onTap: () {
        callWhatsAppText(int.parse(numero),
            '*Virtual Match* \n 💬 Hola Fifero:\n, Te invitamos a jugar en el \n 🔺*Torneo:* ${widget.torneo} \n 🔺*Competición:* ${widget.competicion}\n 🔺*Modalidad :* ${widget.modalidad}');
      },
      child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 35),
    );
  }

  _add(String idJugador) {
    return InkWell(
        onTap: () {
          setState(() {
            _executeInscription(widget.idTorneo.toString(), idJugador);
          });
        },
        child: Shimmer.fromColors(
          baseColor: AppTheme.themeWhite,
          highlightColor: AppTheme.themePurple,
          child: FaIcon(FontAwesomeIcons.users, color: Colors.white, size: 33),
        ));
  }

  _executeInscription(String idTorneo, String idJugador) async {
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
        print('EL RESULTTTTTAAA: ${result["tipo_mensaje"]}');

        if (respuesta == '0') showSnackbar(mensaje, scaffoldKey);
        if (respuesta == '2') showSnackbar(mensaje, scaffoldKey);
      });
    } catch (error) {
      showSnackbar('Usuario registrado !!!', scaffoldKey);
    }
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
                    sizedBox(15.0, 0),
                    DropdownButton(
                      isExpanded: false,
                      dropdownColor: AppTheme.themePurple,
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

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      JugadorModel item = snapshot.data[i];
      lista.add(DropdownMenuItem(
          child: Text(
              item.telefono +
                  ' - ' +
                  item.idPsdn +
                  '\n - ' +
                  item.nombre +
                  ' ' +
                  item.apellido,
              style: TextStyle(color: AppTheme.themeWhite)),
          value: item.idJugador.toString() + '|' + item.telefono));
    }
    return lista;
  }
}
