import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';

import 'package:virtual_match/src/model/entity/EntityFromJson/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/TorneoPersonalizar.dart';
import 'package:virtual_match/src/model/entity/EntityMap/AsignacionModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/tourment/TourmentListPage.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model;
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model1;

class CustomizePlayer extends StatefulWidget {
  int idTorneo;

  CustomizePlayer({this.idTorneo});

  @override
  _CustomizePlayerState createState() => _CustomizePlayerState();
}

class _CustomizePlayerState extends State<CustomizePlayer> {
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _opcionJugador = '1' + '|' + '71298852';
  PlayerService entityGet1 = PlayerService();
  TourmentService servicioTorneoPersonalizar = new TourmentService();
  JugadorModelList entity = new JugadorModelList();
  model.JugadorModel entityModel = new model.JugadorModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar('CREA TU EQUIPO'),
        drawer: DrawerMenu(),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/portada2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                sizedBox(15.0, 20),
                _comboJugador(),
                divider(),
                futureBuilderTorneoPersonalizar(context, widget.idTorneo),
              ],
            ),
          ),
        ),
        floatingActionButton: floatButton(Colors.transparent, context,
            FaIcon(FontAwesomeIcons.arrowLeft), TourmentListPage()),
      ),
    );
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

  Widget futureBuilderTorneoPersonalizar(BuildContext context, int idTorneo) {
    return FutureBuilder(
        future: new TourmentService().getDevuelveTorneoParaPersonalizar(
            new TorneoPersonalizar(), idTorneo),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listViewTorneoPersonalizar(idTorneo, context, snapshot);
          }
        });
  }

  Widget listViewTorneoPersonalizar(
      int idTorneo, BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        TorneoPersonalizar entity = snapshot.data[index];

        return Container(
          child: Column(
            children: [
              Text(
                entity.fechaTorneo,
                style: TextStyle(color: AppTheme.themeWhite),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            entity.fotoIzq,
                            width: 50,
                          ),
                          Text(entity.nombreJugadorIzq.toString(),
                              style: TextStyle(color: AppTheme.themeWhite)),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          ReemplazarJugador reemplazo = new ReemplazarJugador();
                          reemplazo.idJugador = entity.jugadorIzq;
                          var x = _opcionJugador.split('|')[0];
                          reemplazo.idJugadorReemplazo = int.parse(x);
                          reemplazo.idPartido = entity.idPartida;
                          reemplazo.idTorneo = entity.idTorneo;
                          reemplazo.izqDer = "I";
                          reemplazo.states = StateEntity.Insert;
                          llamadaReemplazo(reemplazo);
                        },
                        child: FaIcon(FontAwesomeIcons.retweet,
                            color: AppTheme.themePurple),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            entity.fotoDer,
                            width: 50,
                          ),
                          Text(entity.nombreJugadorDer.toString(),
                              style: TextStyle(color: AppTheme.themeWhite)),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          ReemplazarJugador reemplazo = new ReemplazarJugador();
                          reemplazo.idJugador = entity.jugadorDer;
                          var x = _opcionJugador.split('|')[0];
                          reemplazo.idJugadorReemplazo = int.parse(x);
                          reemplazo.idPartido = entity.idPartida;
                          reemplazo.idTorneo = entity.idTorneo;
                          reemplazo.izqDer = "D";
                          reemplazo.states = StateEntity.Insert;

                          // llamadaReemplazo(reemplazo);

                          _cambiarJugadores(reemplazo);
                        },
                        child: FaIcon(FontAwesomeIcons.retweet,
                            color: AppTheme.themePurple),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 2,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }

  llamadaReemplazo(ReemplazarJugador reemplazo) {
    _cambiarJugadores(reemplazo);
    //setState(() {});

    //futureBuilderTorneoPersonalizar(context, 82);
  }

  _cambiarJugadores(ReemplazarJugador entity) async {
    try {
      await servicioTorneoPersonalizar.cambiarJugadores(entity).then((result) {
        if (result["tipo_mensaje"] == '0')
          setState(() {
            showSnackbar(result["mensaje"], scaffoldKey);
          });
        else
          showSnackbar(result["mensaje"], scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} dddddddd', scaffoldKey);
    }
  }
}
