import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/TablaPosicionesModel.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';

class PositionTable extends StatefulWidget {
  final int idTorneo;

  const PositionTable({Key key, @required this.idTorneo}) : super(key: key);

  @override
  _PositionTableState createState() => _PositionTableState();
}

class _PositionTableState extends State<PositionTable> {
  TablaPosicionesModel entity = new TablaPosicionesModel();

  TourmentService entityGet = TourmentService();

  @override
  Widget build(BuildContext context) {
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getTablaPosiciones(
            new TablaPosicionesModel(), widget.idTorneo),
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
    List entities = snapshot.data;
    return showTablePositions(entities);
  }

  Widget showTablePositions(List entities) {
    int nro = 0;
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DataTable(
                  columnSpacing: 10,
                  horizontalMargin: 10,
                  sortAscending: true,
                  columns: [
                    DataColumn(
                      label: Text(
                        'GRUPO.'.toUpperCase(),
                        style: TextStyle(
                          color: AppTheme.themePurple,
                          fontSize: 10.0,
                        ),
                      ),
                      numeric: false,
                      tooltip: "Equipos".toUpperCase(),
                    ),
                    DataColumn(
                      label: Text(
                        'NRO.'.toUpperCase(),
                        style: TextStyle(
                          color: AppTheme.themePurple,
                          fontSize: 10.0,
                        ),
                      ),
                      numeric: false,
                      tooltip: "Equipos".toUpperCase(),
                    ),
                    DataColumn(
                      label: Text(
                        'Equipos'.toUpperCase(),
                        style: TextStyle(
                          color: AppTheme.themePurple,
                          fontSize: 10.0,
                        ),
                      ),
                      numeric: false,
                      tooltip: "Equipos".toUpperCase(),
                    ),
                    DataColumn(
                      label: Text(
                        'PJ',
                        style: TextStyle(
                          color: AppTheme.themePurple,
                          fontSize: 10.0,
                        ),
                      ),
                      numeric: true,
                      tooltip: "Jugados",
                    ),
                    DataColumn(
                      label: Text(
                        'PG',
                        style: TextStyle(
                          color: AppTheme.themePurple,
                          fontSize: 10.0,
                        ),
                      ),
                      numeric: true,
                      tooltip: "Ganados",
                    ),
                    DataColumn(
                      label: Text(
                        'PE',
                        style: TextStyle(
                          color: AppTheme.themePurple,
                          fontSize: 10.0,
                        ),
                      ),
                      numeric: true,
                      tooltip: "Empatados".toUpperCase(),
                    ),
                    DataColumn(
                      label: Text(
                        'PP',
                        style: TextStyle(
                          color: AppTheme.themePurple,
                          fontSize: 10.0,
                        ),
                      ),
                      numeric: true,
                      tooltip: "Perdidos".toUpperCase(),
                    ),
                    DataColumn(
                      label: Text(
                        'PTS',
                        style: TextStyle(
                          color: AppTheme.themePurple,
                          fontSize: 10.0,
                        ),
                      ),
                      numeric: true,
                      tooltip: "Puntaje total",
                    )
                  ],
                  rows: entities.map(
                    (data) {
                      print(data.nro.toString());
                      String texto = data.tipoCompeticion;
                      if (data.comodin == 52) {
                        texto = texto + " " + data.grupo.toString();
                      }

                      nro = nro + 1;

                      return DataRow(
                        selected: true,
                        cells: [
                          DataCell(
                            Container(
                              width: 70.0,
                              child: Center(
                                child: Text(
                                  texto,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 15.0,
                              child: Center(
                                child: Text(
                                  nro.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 140.0,
                              child: Row(
                                children: <Widget>[
                                  avatarCircle(data.imagenEquipo, 13.0),
                                  Expanded(
                                    child: AutoSizeText(
                                      data.nombreEquipo,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ),

                                  //Text(data.nombreEquipo),
                                ],
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 15.0,
                              child: Center(
                                child: Text(
                                  data.jugados.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 15.0,
                              child: Center(
                                child: Text(
                                  data.puntaje.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 15.0,
                              child: Center(
                                child: Text(
                                  data.empate.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 15.0,
                              child: Center(
                                child: Text(
                                  data.perdida.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 15.0,
                              child: Center(
                                child: Text(
                                  data.puntos.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ).toList(),
                )
              ]),
        ));
  }
}
