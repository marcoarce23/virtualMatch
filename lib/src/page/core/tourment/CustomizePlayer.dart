import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/TorneoPersonalizar.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart';
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
  CustomizePlayer({Key key}) : super(key: key);

  @override
  _CustomizePlayerState createState() => _CustomizePlayerState();
}

class _CustomizePlayerState extends State<CustomizePlayer> {
  String _opcionJugador = '1' + '|' + '71298852';
  PlayerService entityGet1 = PlayerService();
  TourmentService servicioTorneoPersonalizar = new TourmentService();
  JugadorModelList entity = new JugadorModelList();
  model.JugadorModel entityModel = new model.JugadorModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar('CREA TU EQUIPO'),
        drawer: DrawerMenu(),
        body: Container(

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
              futureBuilderTorneoPersonalizar(context, 82),
            ],
          ),
        ),
      ),
    );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        entity.fechaTorneo,
                        style: TextStyle(color: AppTheme.themeWhite),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            print(entity.nombreJugadorIzq.toString());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                entity.fotoIzq,
                                width: 50,
                              ),
                              Text(entity.nombreJugadorIzq.toString(),
                                  style: TextStyle(color: AppTheme.themeWhite)),
                            ],
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            print(entity.nombreJugadorDer.toString());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                entity.fotoDer,
                                width: 50,
                              ),
                              Text(entity.nombreJugadorDer.toString(),
                                  style: TextStyle(color: AppTheme.themeWhite)),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
