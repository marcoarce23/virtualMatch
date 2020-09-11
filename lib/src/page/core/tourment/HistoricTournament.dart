import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/HistoricoTorneoModel.dart';

import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';

class HistoricTournamentPage extends StatefulWidget {
  final int idTorneo;

  const HistoricTournamentPage({Key key, @required this.idTorneo})
      : super(key: key);

  @override
  _HistoricTournamentPageState createState() => _HistoricTournamentPageState();
}

class _HistoricTournamentPageState extends State<HistoricTournamentPage> {
  HistoricoTorneoModel entity = new HistoricoTorneoModel();

  TourmentService entityGet = TourmentService();

  @override
  Widget build(BuildContext context) {
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getHistoricoTorneo(
            new HistoricoTorneoModel(), widget.idTorneo),
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
                    tooltip: "NRO".toUpperCase(),
                  ),
                  DataColumn(
                    label: Text(
                      'Jugador'.toUpperCase(),
                      style: TextStyle(
                        color: AppTheme.themePurple,
                        fontSize: 10.0,
                      ),
                    ),
                    numeric: false,
                    tooltip: "Jugador".toUpperCase(),
                  ),
                  DataColumn(
                    label: Text(
                      'Scored',
                      style: TextStyle(
                        color: AppTheme.themePurple,
                        fontSize: 10.0,
                      ),
                    ),
                    numeric: true,
                    tooltip: "Scored",
                  ),
                  DataColumn(
                    label: Text(
                      'Jugador'.toUpperCase(),
                      style: TextStyle(
                        color: AppTheme.themePurple,
                        fontSize: 10.0,
                      ),
                    ),
                    numeric: true,
                    tooltip: "Jugador".toUpperCase(),
                  ),
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
                                  data.nro.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 110.0,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: AutoSizeText(
                                      data.jugador1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 30.0,
                              child: Center(
                                child: Text(
                                  data.goles.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 110.0,
                              child: Expanded(
                                child: AutoSizeText(
                                  data.jugador2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              )
            ]));
  }
}
