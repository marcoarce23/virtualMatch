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
              return Text('ss');
              break;
            default:
              return listView(context, snapshot);
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;
    List entities = snapshot.data;
    return showTablePositions(entities);
  }

  Widget showTablePositions(List entities) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                rows: entities
                    .map(
                      (data) => DataRow(
                        cells: [
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
                              width: 140.0,
                              child: Row(
                                children: <Widget>[
                                  avatarCircle(data.imagenEquipo, 13.0),
                                  Text(
                                    data.nombreEquipo,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ],
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
                      ),
                    )
                    .toList(),
              )
            ]));
  }
}
