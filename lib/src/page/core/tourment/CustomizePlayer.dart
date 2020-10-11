import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/TorneoPersonalizar.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class CustomizePlayer extends StatefulWidget {
  CustomizePlayer({Key key}) : super(key: key);
  TourmentService servicioTorneoPersonalizar = new TourmentService();

  @override
  _CustomizePlayerState createState() => _CustomizePlayerState();
}

class _CustomizePlayerState extends State<CustomizePlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: futureBuilderTorneoPersonalizar(context, 82),
      ),
    );
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
                        style: TextStyle(color: Colors.black),
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
                                  style: TextStyle(color: Colors.black)),
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
                                  style: TextStyle(color: Colors.black)),
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
