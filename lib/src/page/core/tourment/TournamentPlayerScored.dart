import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/PartidosPorTorneoModel.dart';
import 'package:virtual_match/src/service/core/PartidosPorTorneoService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'RegisterScoredPage.dart';

class TournamentPlayerScored extends StatefulWidget {
  final int idTorneo;

  const TournamentPlayerScored({Key key, @required this.idTorneo})
      : super(key: key);

  @override
  _TournamentPlayerScoredState createState() => _TournamentPlayerScoredState();
}

class _TournamentPlayerScoredState extends State<TournamentPlayerScored> {
  PartidosPorTorneoModel entity = new PartidosPorTorneoModel();
  PartidosPorTorneoService entityService;
  PartidosPorTorneoService entityGet = PartidosPorTorneoService();
  bool esVisto = false;
  @override
  Widget build(BuildContext context) {
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getPartidosTorneoX(
            new PartidosPorTorneoModel(), widget.idTorneo),
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
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          PartidosPorTorneoModel entity = snapshot.data[index];
          return InkWell(
              onTap: () {
                navegation(
                    context,
                    RegisterScoredPage(
                      entity: entity,
                      idTorneo: widget.idTorneo,
                    ));
              },
              child: showScored(entity));
        },
      ),
    );
  }

  Widget showScored(PartidosPorTorneoModel entity) {
    final size = MediaQuery.of(context).size;
    sizedBox(0, 6);
    return Container(
      width: size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          sizedBox(0, 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  avatarCircle(entity.iFoto, 35.0),
                  Text(entity.iJugador),
                  _showAction(entity),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    entity.iGoles.toString() + ' - ' + entity.dGoles.toString(),
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.themeBlackBlack),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: 66,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          stops: [0.1, 0.4, 0.7, 0.9],
                          colors: [
                            Colors.black,
                            Colors.black,
                            Colors.black,
                            Colors.black,
                          ],
                        )),
                    child: Text(
                      entity.estadoPartido,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.themeWhite),
                    ),
                  ),
                  Text(new DateFormat.yMMMMd('es_BO')
                      .format(entity.fechaPartido)),
                  //  Text(entity.nombreTorneo.toString()),
                ],
              ),
              Column(
                children: <Widget>[
                  avatarCircle(entity.dFoto, 35.0),
                  Text(entity.iJugador),
                  _showAction(entity),
                ],
              ),
              sizedBox(0, 6),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showAction(PartidosPorTorneoModel entity) {
    return Row(
      children: <Widget>[
        _phone(),
        sizedBox(15, 0),
        _whatApp(),
      ],
    );
  }

  _phone() {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.phone,
        color: AppTheme.themeDefault,
        size: 25,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }

  _whatApp() {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.whatsapp,
        color: AppTheme.themeDefault,
        size: 25,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }
}
